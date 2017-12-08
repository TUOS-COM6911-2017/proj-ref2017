
############################################################################################
##### PART 1 - BOTH REF AND RAE
#IMPORTING, FISRT LOOK AT DATA, CHANGING: DATATYPES, VAR NAMES, REMOVING VAR, NA->0, REMOVING OUTLIERS

#setwd("Path")

#Installing packages: 1)Reading excel2)Visualization 3) Melting/casting data 
#4) Managing tables with data - filtres, operation, grouping, sorting 5) Nice looking data tables
install.packages("readxl")
install.packages("ggplot2")
install.packages("reshape")
install.packages("data.table")
install.packages('DT')

#Packages that will be needed (Data table, data melting, reshaping, ggplot2 for visualisation)
library(readxl)
library(data.table)
library(ggplot2)
library(plyr)
library(dplyr)
library(DT)
library(reshape)
library(magrittr)
library(tidyr)

############ IMPORTING DATA SUBMISION/RESULTS #############

###Submissions REF/RAE Economy and Econometrics (18;34)
ECON_RAE_INSTITUTION_DICTIONARY<-as.data.table(read.csv("Econometrics_Economy/Institution.csv", header = TRUE, sep=','))
ECON_RAE_OUTPUT<-as.data.table(read.csv("Econometrics_Economy/RA2.csv", header = TRUE, sep=','))
ECON_REF_OUTPUT<-as.data.table(read_excel(path="Econometrics_Economy/REF_Economics and_Econometrics.xlsx", sheet = "Outputs"))
#ECON_REF_OUT_ADDITIONAL<-as.data.table(read_excel(path="Econometrics_Economy/ECON_REF_OUTPUT_ADD.xlsx", sheet = "Output"))

###Results REF/RAE Economy and Econometrics
ECON_REF_RESULTS<-as.data.table(read_excel(path="Econometrics_Economy/Results/uoa18.xlsx"))
ECON_RAE_RESULTS<-as.data.table(read_excel(path="Econometrics_Economy/Results/uoa34.xls"))

############### DATA CLEANING ##############

###removing spaces in a colname
colnames(ECON_REF_OUTPUT) <- gsub(" ", "_", colnames(ECON_REF_OUTPUT))
#changing names for results
colnames(ECON_REF_RESULTS) <- c('UKPRN','Inst_name','Inst_sort_order','Main_panel','UOA_nr','UOA_nam','Multi_letter','Multi_name','Joint_submission','Profile','FTE_cat_A','Four','Three','Two','One','Unclassified')
colnames(ECON_RAE_RESULTS) <- c('Inst_name','FTE_cat_A','Four','Three','Two','One','Unclassified','X2','HESA_INST_CODE','UOA_nr','Multi_letter')

### FIRST LOOK AT THE OUTPUT DATA
str(ECON_REF_OUTPUT)
str(ECON_RAE_OUTPUT)

########### BASIC DATA CLEANING ####################

### CHANGING DATA TYPES
#mutate_at function from dplyr library to apply a function to several columns in a datatable

### REF
cols<-c("Institution_code_(UKPRN)","Institution_name","Main_panel","Unit_of_assessment_number","Unit_of_assessment_name",
        "Multiple_submission_letter","Multiple_submission_name","Joint_submission","Output_type","Publisher","Number_of_additional_authors",
        "Non-english","Year","Interdisciplinary","Proposed_double-weighted","Research_group","Citations_applicable","Cross-_referral_requested")
ECON_REF_OUTPUT %<>% mutate_at(cols, funs(factor(.)))
cols2<-c("Volume","Issue","First_page","Cross-_referral_requested")
ECON_REF_OUTPUT %<>% mutate_at(cols2, funs(as.numeric(.)))
ECON_REF_OUTPUT<-as.data.table(ECON_REF_OUTPUT)

### RAE

# changing types-> factor
cols<-c("JointSubmissionId","Institution","UnitOfAssessment","MultipleSubmission","StaffIdentifier","OutputNumber","Year")
ECON_RAE_OUTPUT %<>% mutate_at(cols, funs(factor(.)))
cols_char<-c("LongTitle","OtherDetails","Pagination")
ECON_RAE_OUTPUT %<>% mutate_at(cols_char, funs(as.character(.)))

#Pagination for RAE changed as First Page in REF
cols_char<-c("LongTitle","OtherDetails","Pagination")
ECON_RAE_OUTPUT$FirstPage = as.character(lapply(strsplit(as.character(ECON_RAE_OUTPUT$Pagination), split="-"), "[", 1))
cols_int<-c("Pagination","NumberofAdditionalAuthors")
ECON_RAE_OUTPUT %<>% mutate_at(cols_int, funs(as.numeric(.)))

rm(cols,cols_char,cols_int,cols2)#removing what unnesseary

ECON_RAE_OUTPUT<-as.data.table(ECON_RAE_OUTPUT)
ECON_REF_OUTPUT<-as.data.table(ECON_REF_OUTPUT)

#How many missing values? - Look at list
ECON_REF_NUM_NA<-ECON_REF_OUTPUT[, sapply(.SD, function(x) sum(!complete.cases(x))/length(Publisher))]
ECON_RAE_NUM_NA<-ECON_RAE_OUTPUT[, sapply(.SD, function(x) sum(!complete.cases(x))/length(Publisher))]

#Removing empty or useless columns

#REF
col_rm_REF_O<-c("Institution_code_(UKPRN)", "Main_panel","Unit_of_assessment_number","Multiple_submission_letter", "Multiple_submission_name","Joint_submission","Place", "Article_number", 
                "ISBN", "ISSN", "DOI","Issue","URL", "Patent_number","Non-english","Interdisciplinary","Proposed_double-weighted","Research_group","Cross-_referral_requested","Citations_applicable")
ECON_REF_OUTPUT[,col_rm_REF_O]<- NULL

#RAE
col_rm_RAE_O<-c("JointSubmissionId", "UnitOfAssessment ","MultipleSUbmission","Pagination", "EndDate","ISBN","URL","DOI")
ECON_RAE_OUTPUT[,col_rm_RAE_O]<- NULL

# T/F->1/0
col_logical <- c("IsInterdisciplinary")
for (var in col_logical) ECON_RAE_OUTPUT[, var:= as.numeric(get(var)), with=FALSE]

# NA ->0
cols_na<-c('Publisher','First_page','Citation_count',
           'Number_of_additional_authors','Volume_title', 'Volume')
ECON_REF_OUTPUT[,(cols2) := lapply(.SD, function(x) {ifelse(is.na(x),0,x)}),
                .SDcols = cols2]

rm(col_logical,col_rm_REF_O, col_rm_RAE_O,var,cols_na)#removing unnecessary filters
rm(ECON_RAE_NUM_NA,ECON_REF_NUM_NA)

############ DATA NORMALIZATION ##########

#Outliers - First page
ECON_REF_OUTPUT$First_page<-ifelse(ECON_REF_OUTPUT$First_page==0,
                                   median(ECON_REF_OUTPUT$First_page),
                                   ECON_REF_OUTPUT$First_page)
#ECON_REF_OUTPUT$First_page<-ifelse(First_page>(median(First_page)+abs(-3*sd(First_page))),median(First_page),First_page)

median_outliers <- function(x, na.rm = TRUE, ...) {
  qnt <- quantile(x, probs=c(.25, .75), na.rm = na.rm, ...)
  H <- 1.5 * IQR(x, na.rm = na.rm)
  y <- x
  y[x < (qnt[1] - H)] <- NA
  y[x > (qnt[2] + H)] <- NA
  y
}

ECON_REF_OUTPUT$First_page<-median_outliers(ECON_REF_OUTPUT$First_page)

ECON_REF_OUTPUT<-as.data.table(ECON_REF_OUTPUT)
str(ECON_REF_OUTPUT)

###BETTER WAY ~ INTERVALS

ECON_REF_OUTPUT$First_page_trial<- cut(ECON_REF_OUTPUT$First_page, 
                                       breaks = c(0, 250, 500, 750, 1000, 1250, 1500, 1750, 2000, 5000), 
                                       labels = c("1","2","3","4","5","6","7","8","9"), 
                                       #labels : ("0-250","250-500","500-750","750-1000","1000-1250", "1250-1500","1500-1750","1750-2000","2000-2500")
                                       right = FALSE)
