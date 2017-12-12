setwd("/Users/gosc/Desktop/TEAM_PROJECT/DataTenUOAs")
getwd()

library(readxl)
library(data.table)
library(ggplot2)
library(plyr)
library(dplyr)
library(DT)
library(reshape)
library(magrittr)
library(tidyr)

####### IMPORTING DATA REF
############ OUTPUT #############

EconomyOutput<-as.data.table(read_excel(path="Economics.xlsx", sheet = "Outputs"))
PhysicsOutput<-as.data.table(read_excel(path="Physics.xlsx", sheet = "Outputs"))
AntropologyOutput<-as.data.table(read_excel(path="Antropology.xlsx", sheet = "Outputs"))
PublicHealthOutput<-as.data.table(read_excel(path="PublicHealth.xlsx", sheet = "Outputs"))
AeronauticalOutput<-as.data.table(read_excel(path="Aeronautical.xlsx", sheet = "Outputs"))
CommunicationOutput<-as.data.table(read_excel(path="Communication.xlsx", sheet = "Outputs"))
BiologicalScienceOutput<-as.data.table(read_excel(path="BiologicalSciences.xlsx", sheet = "Outputs"))
ComputerScienceOutput<-as.data.table(read_excel(path="ComputerScience.xlsx", sheet = "Outputs"))
EducationOutput<-as.data.table(read_excel(path="Education.xlsx", sheet = "Outputs"))
PhilosophyOutput<-as.data.table(read_excel(path="Philosophy.xlsx", sheet = "Outputs"))


#Data cleaning

colnames(EconomyOutput)<-gsub(" ", "_", colnames(EconomyOutput))
colnames(PhysicsOutput)<-gsub(" ", "_", colnames(PhysicsOutput))
colnames(AntropologyOutput)<-gsub(" ", "_", colnames(AntropologyOutput))
colnames(PublicHealthOutput)<-gsub(" ", "_", colnames(PublicHealthOutput))
colnames(AeronauticalOutput)<-gsub(" ", "_", colnames(AeronauticalOutput))
colnames(CommunicationOutput)<-gsub(" ", "_", colnames(CommunicationOutput))
colnames(BiologicalScienceOutput)<-gsub(" ", "_", colnames(BiologicalScienceOutput))
colnames(ComputerScienceOutput)<-gsub(" ", "_", colnames(ComputerScienceOutput))
colnames(EducationOutput)<-gsub(" ", "_", colnames(EducationOutput))
colnames(PhilosophyOutput)<-gsub(" ", "_", colnames(PhilosophyOutput))



#Removing unused columns

#REF
colnames(EducationOutput)
col_rm<-c("Main_panel","Volume","Volume_title","Unit_of_assessment_number","Number_of_additional_authors",
                "Article_number", "First_page", "Title", "Place", "Publisher", "ISBN", "ISSN", "DOI","Issue",
          "URL", "Patent_number","Non-english","Interdisciplinary","Proposed_double-weighted",
          "Research_group","Cross-_referral_requested","Citations_applicable")
PhysicsOutput[,col_rm]<- NULL
EconomyOutput[,col_rm]<- NULL
AntropologyOutput[,col_rm]<- NULL
PublicHealthOutput[,col_rm]<- NULL
AeronauticalOutput[,col_rm]<- NULL
CommunicationOutput[,col_rm]<- NULL
ComputerScienceOutput[,col_rm]<- NULL
BiologicalScienceOutput[,col_rm]<- NULL
EducationOutput[,col_rm]<- NULL
PhilosophyOutput[,col_rm]<- NULL
PhysicsOutput[,5]<- NULL


factor<-c("Institution_code_(UKPRN)","Institution_name","Unit_of_assessment_name","Output_type","Year")                  
PhysicsOutput %<>% mutate_at(factor, funs(factor(.)))
EconomyOutput %<>% mutate_at(factor, funs(factor(.)))
AntropologyOutput %<>% mutate_at(factor, funs(factor(.)))
PublicHealthOutput %<>% mutate_at(factor, funs(factor(.)))
AeronauticalOutput %<>% mutate_at(factor, funs(factor(.)))
CommunicationOutput %<>% mutate_at(factor, funs(factor(.)))
ComputerScienceOutput %<>% mutate_at(factor, funs(factor(.)))
BiologicalScienceOutput %<>% mutate_at(factor, funs(factor(.)))
EducationOutput %<>% mutate_at(factor, funs(factor(.)))
PhilosophyOutput %<>% mutate_at(factor, funs(factor(.)))

numeric<-"Citation_count"
PhysicsOutput %<>% mutate_at(numeric, funs(as.numeric(.)))
EconomyOutput %<>% mutate_at(numeric, funs(as.numeric(.)))
AntropologyOutput %<>% mutate_at(numeric, funs(as.numeric(.)))
PublicHealthOutput %<>% mutate_at(numeric, funs(as.numeric(.)))
AeronauticalOutput %<>% mutate_at(numeric, funs(as.numeric(.)))
CommunicationOutput %<>% mutate_at(numeric, funs(as.numeric(.)))
ComputerScienceOutput %<>% mutate_at(numeric, funs(as.numeric(.)))
BiologicalScienceOutput %<>% mutate_at(numeric, funs(as.numeric(.)))
EducationOutput %<>% mutate_at(numeric, funs(as.numeric(.)))
PhilosophyOutput %<>% mutate_at(numeric, funs(as.numeric(.)))



###NUMBER OF SUBMISSIONS
EconomyOutput<-as.data.table(EconomyOutput)
PhysicsOutput<-as.data.table(PhysicsOutput)
AntropologyOutput<-as.data.table(AntropologyOutput)
PublicHealthOutput<-as.data.table(PublicHealthOutput)
AeronauticalOutput<-as.data.table(AeronauticalOutput)
CommunicationOutput<-as.data.table(CommunicationOutput)
BiologicalScienceOutput<-as.data.table(BiologicalScienceOutput)
ComputerScienceOutput<-as.data.table(ComputerScienceOutput)
EducationOutput<-as.data.table(EducationOutput)
PhilosophyOutput<-as.data.table(PhilosophyOutput)


OUTPUTall<-as.data.table(rbind(EconomyOutput,PhysicsOutput, AntropologyOutput,PublicHealthOutput,AeronauticalOutput,
                               CommunicationOutput,BiologicalScienceOutput,ComputerScienceOutput,EducationOutput,PhilosophyOutput))
########

EconomyOutputNr<-EconomyOutput[,.(.N, category="Economy"), Institution_name][order(-N)]
PhysicsOutputNr<-PhysicsOutput[,.(.N, category="Physics"), Institution_name][order(-N)]
AntropologyOutputNr<-AntropologyOutput[,.(.N, category="Antropology"), Institution_name][order(-N)]
PublicHealthOutputNr<-PublicHealthOutput[,.(.N, category="PublicHealth"), Institution_name][order(-N)]
AeronauticalOutputNr<-AeronauticalOutput[,.(.N, category="Aeronautical"), Institution_name][order(-N)]
CommunicationOutputNr<-CommunicationOutput[,.(.N, category="Communication"), Institution_name][order(-N)]
BiologicalScienceOutputNr<-BiologicalScienceOutput[,.(.N, category="BiologicalScience"), Institution_name][order(-N)]
ComputerScienceOutputNr<-ComputerScienceOutput[,.(.N, category="ComputerScience"), Institution_name][order(-N)]
EducationOutputNr<-EducationOutput[,.(.N, category="Education"), Institution_name][order(-N)]
PhilosophyOutputNr<-PhilosophyOutput[,.(.N, category="Philosophy"), Institution_name][order(-N)]


##### MAIN PLOT WITH NUNMBER OF SUBMISSIONS
NumberOfOutputs<-as.data.table(rbind(EconomyOutputNr,PhysicsOutputNr, AntropologyOutputNr,PublicHealthOutputNr,AeronauticalOutputNr,
                                     CommunicationOutputNr,BiologicalScienceOutputNr,ComputerScienceOutputNr,EducationOutputNr,PhilosophyOutputNr))
rm(EconomyOutputNr,PhysicsOutputNr, AntropologyOutputNr,PublicHealthOutputNr,AeronauticalOutputNr,
   CommunicationOutputNr,BiologicalScienceOutputNr,ComputerScienceOutputNr,EducationOutputNr,PhilosophyOutputNr)
colnames(NumberOfOutputs)<-c("Name","Num","category")


plotMain<- ggplot(NumberOfOutputs, aes(y=Num, x=category, color=category))
plotMain+ geom_boxplot()+geom_jitter(alpha=0.5)+ggtitle("Number of submission per UOA") +
  ylab("Number")+
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10),
        axis.text.x =element_text(angle = 90, hjust = 1),
        legend.position="none")


############ RESULT #############

EconomyResult<-as.data.table(read_excel(path="Economics.xlsx", sheet = "Profiles"))
PhysicsResult<-as.data.table(read_excel(path="Physics.xlsx", sheet = "Profiles"))
AntropologyResult<-as.data.table(read_excel(path="Antropology.xlsx", sheet = "Profiles"))
PublicHealthResult<-as.data.table(read_excel(path="PublicHealth.xlsx", sheet = "Profiles"))
AeronauticalResult<-as.data.table(read_excel(path="Aeronautical.xlsx", sheet = "Profiles"))
CommunicationResult<-as.data.table(read_excel(path="Communication.xlsx", sheet = "Profiles"))
BiologicalScienceResult<-as.data.table(read_excel(path="BiologicalSciences.xlsx", sheet = "Profiles"))
ComputerScienceResult<-as.data.table(read_excel(path="ComputerScience.xlsx", sheet = "Profiles"))
EducationResult<-as.data.table(read_excel(path="Education.xlsx", sheet = "Profiles"))
PhilosophyResult<-as.data.table(read_excel(path="Philosophy.xlsx", sheet = "Profiles"))



col<-c("UKPRN","Name","MainPanel","UOA","NameUOA","Profile","FTEcatA",
       "FourStar","ThreeStar","TwoStar","OneStar","Unclassified")


colnames(PhysicsResult)<-col
colnames(EconomyResult)<-col
colnames(AntropologyResult)<-col
colnames(PublicHealthResult)<-col
colnames(AeronauticalResult)<-col
colnames(CommunicationResult)<-col
colnames(ComputerScienceResult)<-col
colnames(BiologicalScienceResult)<-col
colnames(EducationResult)<-col
colnames(PhilosophyResult)<-col


EconomyResult[,':='(category="Economy")]
PhysicsResult[,':='(category="Physics")]
AntropologyResult[,':='(category="Antropology")]
PublicHealthResult[,':='(category="PublicHealth")]
AeronauticalResult[,':='(category="Aeronautical")]
CommunicationResult[,':='(category="Communication")]
BiologicalScienceResult[,':='(category="BiologicalScience")]
ComputerScienceResult[,':='(category='ComputerScience')]
EducationResult[,':='(category="Education")]
PhilosophyResult[,':='(category="Philosophy")]


###Results Overall

EconomyResultOverall<-EconomyResult[Profile=="Overall",c(2,7,8,9,10,11,12,13)]
PhysicsResultOverall<-PhysicsResult[Profile=="Overall",c(2,7,8,9,10,11,12,13)]
AntropologyResultOverall<-AntropologyResult[Profile=="Overall",c(2,7,8,9,10,11,12,13)]
PublicHealthResultOverall<-PublicHealthResult[Profile=="Overall",c(2,7,8,9,10,11,12,13)]
AeronauticalResultOverall<-AeronauticalResult[Profile=="Overall",c(2,7,8,9,10,11,12,13)]
CommunicationResultOverall<-CommunicationResult[Profile=="Overall",c(2,7,8,9,10,11,12,13)]
BiologicalScienceResultOverall<-BiologicalScienceResult[Profile=="Overall",c(2,7,8,9,10,11,12,13)]
ComputerScienceResultOverall<-ComputerScienceResult[Profile=="Overall",c(2,7,8,9,10,11,12,13)]
EducationResultOverall<-EducationResult[Profile=="Overall",c(2,7,8,9,10,11,12,13)]
PhilosophyResultOverall<-PhilosophyResult[Profile=="Overall",c(2,7,8,9,10,11,12,13)]


ResultsOverall<-as.data.table(rbind(EconomyResultOverall,PhysicsResultOverall,AntropologyResultOverall,
                                    PublicHealthResultOverall,AeronauticalResultOverall,
                                    CommunicationResultOverall,BiologicalScienceResultOverall,ComputerScienceResultOverall,
                                    EducationResultOverall,PhilosophyResultOverall))

rm(EconomyResultOverall,PhysicsResultOverall,AntropologyResultOverall,
   PublicHealthResultOverall,AeronauticalResultOverall,
   CommunicationResultOverall,BiologicalScienceResultOverall,ComputerScienceResultOverall,
   EducationResultOverall,PhilosophyResultOverall)

###Results Output

EconomyResultOutput<-EconomyResult[Profile=="Outputs",c(2,7,8,9,10,11,12,13)]
PhysicsResultOutput<-PhysicsResult[Profile=="Outputs",c(2,7,8,9,10,11,12,13)]
AntropologyResultOutput<-AntropologyResult[Profile=="Outputs",c(2,7,8,9,10,11,12,13)]
PublicHealthResultOutput<-PublicHealthResult[Profile=="Outputs",c(2,7,8,9,10,11,12,13)]
AeronauticalResultOutput<-AeronauticalResult[Profile=="Outputs",c(2,7,8,9,10,11,12,13)]
CommunicationResultOutput<-CommunicationResult[Profile=="Outputs",c(2,7,8,9,10,11,12,13)]
BiologicalScienceResultOutput<-BiologicalScienceResult[Profile=="Outputs",c(2,7,8,9,10,11,12,13)]
ComputerScienceResultOutput<-ComputerScienceResult[Profile=="Outputs",c(2,7,8,9,10,11,12,13)]
EducationResultOutput<-EducationResult[Profile=="Outputs",c(2,7,8,9,10,11,12,13)]
PhilosophyResultOutput<-PhilosophyResult[Profile=="Outputs",c(2,7,8,9,10,11,12,13)]

ResultsOutput<-as.data.table(rbind(EconomyResultOutput,PhysicsResultOutput,AntropologyResultOutput,
                                    PublicHealthResultOutput,AeronauticalResultOutput,
                                    CommunicationResultOutput,BiologicalScienceResultOutput,ComputerScienceResultOutput,
                                    EducationResultOutput,PhilosophyResultOutput))

rm(EconomyResultOutput,PhysicsResultOutput,AntropologyResultOutput,
   PublicHealthResultOutput,AeronauticalResultOutput,
   CommunicationResultOutput,BiologicalScienceResultOutput,ComputerScienceResultOutput,
   EducationResultOutput,PhilosophyResultOutput)

####### Income

EconomyIncome<-as.data.table(read_excel(path="Economics.xlsx", sheet = "Research income"))
PhysicsIncome<-as.data.table(read_excel(path="Physics.xlsx", sheet = "Research income"))
Antropologyincome<-as.data.table(read_excel(path="Antropology.xlsx", sheet = "Research income"))
PublicHealthincome<-as.data.table(read_excel(path="PublicHealth.xlsx", sheet = "Research income"))
Aeronauticalincome<-as.data.table(read_excel(path="Aeronautical.xlsx", sheet = "Research income"))
Communicationincome<-as.data.table(read_excel(path="Communication.xlsx", sheet = "Research income"))
BiologicalScienceincome<-as.data.table(read_excel(path="BiologicalSciences.xlsx", sheet = "Research income"))
ComputerScienceincome<-as.data.table(read_excel(path="ComputerScience.xlsx", sheet = "Research income"))
Educationincome<-as.data.table(read_excel(path="Education.xlsx", sheet = "Research income"))
Philosophyincome<-as.data.table(read_excel(path="Philosophy.xlsx", sheet = "Research income"))


###### 
cols2<-c("UKPRN","Name","Source","Income2008","Income2009","Income2010","Income2011","Income2012")

EconomyIncome<-EconomyIncome[,c(1,2,6,7,8,9,10,11)]
colnames(EconomyIncome)<-cols2

PhysicsIncome<-PhysicsIncome[,c(1,2,6,7,8,9,10,11)]
colnames(PhysicsIncome)<-cols2

Antropologyincome<-Antropologyincome[,c(1,2,6,7,8,9,10,11)]
colnames(Antropologyincome)<-cols2

PublicHealthincome<-PublicHealthincome[,c(1,2,6,7,8,9,10,11)]
colnames(PublicHealthincome)<-cols2

Aeronauticalincome<-Aeronauticalincome[,c(1,2,6,7,8,9,10,11)]
colnames(Aeronauticalincome)<-cols2


Communicationincome<-Communicationincome[,c(1,2,6,7,8,9,10,11)]
colnames(Communicationincome)<-cols2

BiologicalScienceincome<-BiologicalScienceincome[,c(1,2,6,7,8,9,10,11)]
colnames(BiologicalScienceincome)<-cols2

ComputerScienceincome<-ComputerScienceincome[,c(1,2,6,7,8,9,10,11)]
colnames(ComputerScienceincome)<-cols2

Educationincome<-Educationincome[,c(1,2,6,7,8,9,10,11)]
colnames(Educationincome)<-cols2

Philosophyincome<-Philosophyincome[,c(1,2,6,7,8,9,10,11)]
colnames(Philosophyincome)<-cols2


EconomyIncome[,':='(SumIncome=(Income2008+Income2009+Income2010+Income2011+Income2012),category="Economy")]
PhysicsIncome[,':='(SumIncome=(Income2008+Income2009+Income2010+Income2011+Income2012),category="Physics")]
Antropologyincome[,':='(SumIncome=(Income2008+Income2009+Income2010+Income2011+Income2012),category="Antropology")]
PublicHealthincome[,':='(SumIncome=(Income2008+Income2009+Income2010+Income2011+Income2012),category="PublicHealth")]
Aeronauticalincome[,':='(SumIncome=(Income2008+Income2009+Income2010+Income2011+Income2012),category="Aeronautical")]
Communicationincome[,':='(SumIncome=(Income2008+Income2009+Income2010+Income2011+Income2012),category="Communication")]
BiologicalScienceincome[,':='(SumIncome=(Income2008+Income2009+Income2010+Income2011+Income2012),category="BiologicalScience")]
ComputerScienceincome[,':='(SumIncome=(Income2008+Income2009+Income2010+Income2011+Income2012),category='ComputerScience')]
Educationincome[,':='(SumIncome=(Income2008+Income2009+Income2010+Income2011+Income2012),category="Education")]
Philosophyincome[,':='(SumIncome=(Income2008+Income2009+Income2010+Income2011+Income2012),category="Philosophy")]


IncomeCategorySource<-as.data.table(rbind(EconomyIncome,PhysicsIncome,Antropologyincome,PublicHealthincome,Aeronauticalincome,Communicationincome,
                               BiologicalScienceincome,ComputerScienceincome,Educationincome,Philosophyincome))
rm(EconomyIncome,PhysicsIncome,Antropologyincome,PublicHealthincome,Aeronauticalincome,Communicationincome,
                       BiologicalScienceincome,ComputerScienceincome,Educationincome,Philosophyincome)
IncomeCategorySource<-IncomeCategorySource[,c(1,2,3,9,10)]
IncomeCategorySource<-IncomeCategorySource[,.(SumIncome=SumIncome/1000),by=c("Name","category")]
IncomeCategory<-IncomeCategorySource[,.(TotIncome=sum(SumIncome)/1000),by=c("Name","category")]

AvgIncome<-merge(NumberOfOutputs, IncomeCategory, by.x=c("Institution_name", "category"), by.y=c("Name","category"), all.y=T)
colnames(AvgIncome)<-c("Name","Category","Submission","TotIncome")
AvgIncome[,':='(AvgIncome=TotIncome/Submission)]



#Citation
EconomyCitationNr<-EconomyOutput[!is.na(Citation_count),.(Citation=sum(Citation_count), category="Economy"), Institution_name]
PhysicsCitationNr<-PhysicsOutput[!is.na(Citation_count),.(Citation=sum(Citation_count), category="Physics"), Institution_name]
AntropologyCitationNr<-AntropologyOutput[!is.na(Citation_count),.(Citation=sum(Citation_count), category="Antropology"), Institution_name]
PublicHealthCitationNr<-PublicHealthOutput[!is.na(Citation_count),.(Citation=sum(Citation_count), category="PublicHealth"), Institution_name]
AeronauticalCitationNr<-AeronauticalOutput[!is.na(Citation_count),.(Citation=sum(Citation_count), category="Aeronautical"), Institution_name]
CommunicationCitationNr<-CommunicationOutput[!is.na(Citation_count),.(Citation=sum(Citation_count), category="Communication"), Institution_name]
BiologicalScienceCitationNr<-BiologicalScienceOutput[!is.na(Citation_count),.(Citation=sum(Citation_count), category="BiologicalScience"), Institution_name]
ComputerScienceCitationNr<-ComputerScienceOutput[!is.na(Citation_count),.(Citation=sum(Citation_count), category="ComputerScience"), Institution_name]
EducationCitationNr<-EducationOutput[!is.na(Citation_count),.(Citation=sum(Citation_count), category="Education"), Institution_name]
PhilosophyCitationNr<-PhilosophyOutput[!is.na(Citation_count),.(Citation=sum(Citation_count), category="Philosophy"), Institution_name]

#Binding citation

NumberOfCitation<-as.data.table(rbind(EconomyCitationNr,PhysicsCitationNr, AntropologyCitationNr,PublicHealthCitationNr,AeronauticalCitationNr,
                                     CommunicationCitationNr,BiologicalScienceCitationNr,ComputerScienceCitationNr,EducationCitationNr,PhilosophyCitationNr))
rm(EconomyCitationNr,PhysicsCitationNr, AntropologyCitationNr,PublicHealthCitationNr,AeronauticalCitationNr,
   CommunicationCitationNr,BiologicalScienceCitationNr,ComputerScienceCitationNr,EducationCitationNr,PhilosophyCitationNr)


AvgCit<-merge(NumberOfOutputs, NumberOfCitation, by=c("Institution_name", "category"), all.y=T)

colnames(AvgCit)<-c("Institution_name","category","Submission","Citation")
AvgCit[,':='(AvgCitation=Citation/Submission)]
#AvgCit<-merge(NumberOfOutputs, NumberOfCitation, by=c("Institution_name", "category"), all.y=T)

plotC2 <- ggplot(AvgCit, aes(y=AvgCitation, x=category, color=category))
plotC2+ geom_boxplot()+geom_jitter(alpha=0.5)+ggtitle("Avg. number citations per submission") +
  ylab("Number")+
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10),
        axis.text.x =element_text(angle = 90, hjust = 1),
        legend.position="none")


##MERGING EVRYTHING

AvgCitFourStarOverall<-merge(AvgCit,ResultsOverall, by.x=c("Institution_name","category"), by.y=c("Name","category"), all.y=T)
AvgCitFourStarOutput<-merge(AvgCit,ResultsOutput, by.x=c("Institution_name","category"), by.y=c("Name","category"), all.y=T)

CitIncFourStarOverall<-merge(AvgCitFourStarOverall, AvgIncome, by.x=c("Institution_name","category"), by.y=c("Name","Category"), all.x=T)
CitIncFourStarOutput<-merge(AvgCitFourStarOutput, AvgIncome, by.x=c("Institution_name","category"), by.y=c("Name","Category"), all.x=T)

rm(AvgCitFourStarOverall,AvgCitFourStarOverall)

CitIncFourStarOverall[is.na(CitIncFourStarOverall)]<-0
CitIncFourStarOutput[is.na(CitIncFourStarOutput)]<-0

CitIncFourStarOverall$Institution_name<-as.factor(CitIncFourStarOverall$Institution_name)
CitIncFourStarOverall$category<-as.factor(CitIncFourStarOverall$category)
Star<-c("FourStar","ThreeStar","TwoStar","OneStar")
CitIncFourStarOverall%<>% mutate_at(Star, funs(as.numeric(.)))

CitIncFourStarOutput$Institution_name<-as.factor(CitIncFourStarOutput$Institution_name)
CitIncFourStarOutput$category<-as.factor(CitIncFourStarOutput$category)
Star<-c("FourStar","ThreeStar","TwoStar","OneStar")
CitIncFourStarOutput%<>% mutate_at(Star, funs(as.numeric(.)))



# ---------- CITATATION COUNT ---------

str(CitIncFourStarOverall)
####Overall
p1 <- ggplot(CitIncFourStarOverall, aes(category, AvgCitation, color=category))
p1<-p1 + geom_jitter(position=position_jitter(width=.05, height=0), size=0.8) +
  geom_boxplot(outlier.shape=NA, alpha=0.5) + #avoid plotting outliers twice
  theme(axis.text.x = element_text(angle = 90, hjust = 1),legend.position = "none")+
  ggtitle("Citation Count per UOA") +
  xlab("") +
  ylab("Citations count") +
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10))

p2<-ggplot(CitIncFourStarOverall, aes(FourStar, AvgCitation, color=category))
p2<-p2 + geom_point(size=0.5, alpha=0.5) + 
  geom_smooth(formula = y ~ x)+
  # geom_smooth(alpha=0.5)+
  theme(axis.text.x = element_text(angle = 90, 
                                   hjust = 1),legend.position = "bottom")+
  ggtitle("Average citation vs. 4* overall") +
  xlab("Avg. Number of Citation") +
  ylab("% of 4*") +
  xlim(0,65)+
  scale_y_continuous(limits=c(0, 80))+#scale without one outlier
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10))


multiplot(p1,p2, cols=2)

p3<-ggplot(CitIncFourStarOverall, aes((TwoStar+OneStar), AvgCitation, color=category))
p3 + geom_point(size=0.5, alpha=0.5) + 
  geom_smooth(formula = y ~ x)+
  # geom_smooth(alpha=0.5)+
  theme(axis.text.x = element_text(angle = 90, 
                                   hjust = 1),legend.position = "bottom")+
  ggtitle("Average citation vs. 2*/1* overall") +
  xlab("Avg. Number of Citation") +
  ylab("% of 4*") +
  xlim(0,65)+
  scale_y_continuous(limits=c(0, 80))+#scale without one outlier
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10))

#Output

p1b <- ggplot(CitIncFourStarOutput, aes(category, AvgCitation, color=category))
p1b<-p1b + geom_jitter(position=position_jitter(width=.05, height=0), size=0.8) +
  geom_boxplot(outlier.shape=NA, alpha=0.5) + #avoid plotting outliers twice
  theme(axis.text.x = element_text(angle = 90, hjust = 1),legend.position = "none")+
  ggtitle("Citation Count per UOA - Output") +
  xlab("") +
  ylab("Citations count") +
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10))

str(CitIncFourStarOutput)
p2b<-ggplot(CitIncFourStarOutput, aes(FourStar, AvgCitation, color=category))
p2b<-p2b + geom_point(size=0.5, alpha=0.5) + 
  geom_smooth(formula = y ~ x)+
  theme(axis.text.x = element_text(angle = 90, hjust = 1),legend.position = "bottom")+
  ggtitle("Average citation vs. 4* Output") +
  xlab("Avg. Number of Citation") +
  ylab("% of 4*") +
  xlim(0,55)+
  scale_y_continuous(limits=c(0, 80))+#scale without one outlier
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10))


multiplot(p1b,p2b, cols=2)

p3b<-ggplot(CitIncFourStarOutput, aes((TwoStar+OneStar), AvgCitation, color=category))
p3b + geom_point(size=0.5, alpha=0.5) + 
  geom_smooth(formula = y ~ x)+
  # geom_smooth(alpha=0.5)+
  theme(axis.text.x = element_text(angle = 90, 
                                   hjust = 1),legend.position = "bottom")+
  ggtitle("Average citation vs. 2*/1* Output") +
  xlab("Avg. Number of Citation") +
  ylab("% of 4*") +
  xlim(0,65)+
  scale_y_continuous(limits=c(0, 80))+#scale without one outlier
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10))



colnames(CitIncFourStarOverall)
#_______Inocme ______#
##Total
#Overall
i1 <- ggplot(CitIncFourStarOverall, aes(category, TotIncome/1000, color=category))
i1<-i1 + geom_jitter(position=position_jitter(width=.05, height=0), size=0.8) +
  geom_boxplot(outlier.shape=NA, alpha=0.5) + #avoid plotting outliers twice
  theme(axis.text.x = element_text(angle = 90, hjust = 1),legend.position = "none")+
  ggtitle("Total Income per University") +
  xlab("") +
  ylab("Income in millions") +
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10))

i2<-ggplot(CitIncFourStarOverall, aes(FourStar, TotIncome/1000, color=category))
i2<-i2 + geom_point(size=0.5, alpha=0.5) + 
  geom_smooth(formula = y ~ x)+
  # geom_smooth(alpha=0.5)+
  theme(axis.text.x = element_text(angle = 90, 
                                   hjust = 1),legend.position = "none")+
  ggtitle("Total Income vs. 4* overall") +
  xlab("") +
  ylab("% of 4*") +
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10))


multiplot(i1,i2, cols=2)

#Output
i1b <- ggplot(CitIncFourStarOutput, aes(category, TotIncome/1000, color=category))
i1b<-i1b + geom_jitter(position=position_jitter(width=.05, height=0), size=0.8) +
  geom_boxplot(outlier.shape=NA, alpha=0.5) + #avoid plotting outliers twice
  theme(axis.text.x = element_text(angle = 90, hjust = 1),legend.position = "none")+
  ggtitle("Total Income per University") +
  xlab("") +
  ylab("Income in millions") +
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10))

i2b<-ggplot(CitIncFourStarOutput, aes(FourStar, TotIncome/1000, color=category))
i2b<-i2b + geom_point(size=0.5, alpha=0.5) + 
  geom_smooth(formula = y ~ x)+
  # geom_smooth(alpha=0.5)+
  theme(axis.text.x = element_text(angle = 90, 
                                   hjust = 1),legend.position = "none")+
  ggtitle("Total Income vs. 4* overall") +
  xlab("") +
  ylab("% of 4*") +
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10))


multiplot(i1b,i2b, cols=2)

#########OLD THINGS


colnames(IncomeCategorySource)
colnames(IncomeCategory)
colnames(IncomeCategorySource)<-c("UKPRN","Name","Source","Income","category" )
#Table IncomeByInst we created earlier; we want to knowe the %
IncomeBySource<-merge(IncomeCategorySource,IncomeCategory, by=c("Name","category"), all.x=T)
IncomeBySource<-IncomeBySource[,':='(perc=SumIncome/TotIncome)]

#### ***Visualization***
ggplot(IncomeByInstSour, aes(Institution_name, perc)) +
  geom_bar(colour="black", aes(fill=Source), stat="identity", position = position_stack(reverse = TRUE)) +
  coord_flip() +
  theme(legend.position = "top") +
  ggtitle("REF Percentage of stars")+
  ylab("% of income") +
  xlab("Institution name") +
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=12))


colnames(ECON_RAE_SUMMARY_NUM)<-c('Inst_name','Number_Sub')
ECON_table_number_of_works<-merge(RES_ECRAE_OUTPUT,ECON_RAE_SUMMARY_NUM, by="Inst_name")#Now we have table with umber of works



#________ FTE 4 SCORE_______##


#Overall
f1 <- ggplot(CitIncFourStarOverall, aes(category, FTEcatA, color=category))
f1<-f1 + geom_jitter(position=position_jitter(width=.05, height=0), size=0.8) +
  geom_boxplot(outlier.shape=NA, alpha=0.5) + #avoid plotting outliers twice
  theme(axis.text.x = element_text(angle = 90, hjust = 1),legend.position = "none")+
  ggtitle("FTE 4 Staff vs 4* overall") +
  xlab("Category") +
  ylab("") +
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10))

f2<-ggplot(CitIncFourStarOverall, aes(y=FourStar, x=FTEcatA, color=category))
f2<-f2 + geom_point(size=0.5, alpha=0.5) + 
  geom_smooth(formula = y ~ x, se=FALSE)+
  # geom_smooth(alpha=0.5)+
  theme(axis.text.x = element_text(angle = 90, 
                                   hjust = 1),legend.position = "none")+
  ggtitle("FTE 4 Staff vs 4* overall") +
  xlab("") +
  ylab("% of 4*") +
  xlim(0,200)+
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10))


multiplot(f1,f2, cols=2)

#Output
f1b <- ggplot(CitIncFourStarOutput, aes(category, FTEcatA, color=category))
f1b<-f1b + geom_jitter(position=position_jitter(width=.05, height=0), size=0.8) +
  geom_boxplot(outlier.shape=NA, alpha=0.5) + #avoid plotting outliers twice
  theme(axis.text.x = element_text(angle = 90, hjust = 1),legend.position = "none")+
  ggtitle("FTE 4 Staff vs 4* output") +
  xlab("Category") +
  ylab("") +
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10))

f2b<-ggplot(CitIncFourStarOutput, aes(y=FourStar, x=FTEcatA, color=category))
f2b<-f2b + geom_point(size=0.5, alpha=0.5) + 
  geom_smooth(formula = y ~ x, se=FALSE)+
  theme(axis.text.x = element_text(angle = 90, 
                                   hjust = 1),legend.position = "none")+
  ggtitle("FTE 4 Staff vs 4* output") +
  xlab("") +
  ylab("% of 4*") +
  xlim(0,200)+
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10))

multiplot(f1b,f2b, cols=2)

#____ OUTPUT TYPE _______#


#Overall
levels(OUTPUTall$Unit_of_assessment_name)
OUTPUTall$Output_type<-revalue(OUTPUTall$Output_type, c("A"="Authored book","B"="Edited book", "C"="Chapter in book","R"="Scholarly edition","D"="Journal article","E"="Conference contribution","U"="Working paper",
                                                                    "L"="Artefact","P"="Devices and products","I"="Performance","M"="Exhibition","F"="Patent/published patent application","J"="Composition","K"="Design","N"="Research report for external body",
                                                                    "O"="Confidential report (for external body)", "S"="Research data sets and databases", "G"="Software","H"="Website content","G"="Software","H"="Website content","Q"="Digital or visual media","T"="Other"))
OUTPUTall$Unit_of_assessment_name<-revalue(OUTPUTall$Unit_of_assessment_name, c("Economics and Econometrics" ="Economics" , "Anthropology and Development Studies" ="Antropology",  "Public Health, Health Services and Primary Care" ="PublicHealth",
                                                                                    "Aeronautical, Mechanical, Chemical and Manufacturing Engineering"="Aeronautical"  ,"Communication, Cultural and Media Studies, Library and Information Management"="Communication",
                                                                                    "Biological Sciences"="Biological","Computer Science and Informatics"="ComputerScience"))

OUTPUTallNr<-OUTPUTall[,.(number=.N),by=c("Institution_name","Output_type","Unit_of_assessment_name")][order(-number)]
OUTPUTallNr<- OUTPUTallNr %>%
  complete(Institution_name, Output_type, Unit_of_assessment_name, fill = list(number = 0)) #really nice trick to bake width of the bar the same


ggplot(OUTPUTallNr, aes(x = Unit_of_assessment_name, y=number, fill = Output_type))+ 
  geom_bar(stat = "Identity", width=0.7)+theme_bw(base_size = 12) + theme(axis.text.x=element_text(angle=90,hjust=1)) +
  ggtitle("Number of submissions - Output type")+theme(plot.title = element_text(hjust = 0.5))+xlab("Institution name")+ylab('Number of Submissions')+
  guides(fill=guide_legend(title="Output type"))



rm(ECON_SUMMARYa)
