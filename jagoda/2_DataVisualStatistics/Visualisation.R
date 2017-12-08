
############################################# DATA VISUALIZATION #############################################

######GGplot2 
#Check the link: http://www.cookbook-r.com/Graphs/


#Function to make two graphs on one page
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  library(grid)
  plots <- c(list(...), plotlist)
  numPlots = length(plots)
  if (is.null(layout)) {
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    for (i in 1:numPlots) {
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}

###Tables with number of submision
###Number of submission REF
ECON_REF_SUMMARY_NUM<-ECON_REF_OUTPUT[,.N, Institution_name][order(-N)]

###Number of submission RAE - encoding names
ECON_RAE_INSTITUTION_DICTIONARY$Institution<-as.character(ECON_RAE_INSTITUTION_DICTIONARY$Institution)
ECON_RAE_INSTITUTION_DICTIONARY$Institution<-as.factor(substr(ECON_RAE_INSTITUTION_DICTIONARY$Institution,2,4))
ECON_RAE_OUTPUT<-merge(ECON_RAE_INSTITUTION_DICTIONARY[,Institution,InstitutionName],ECON_RAE_OUTPUT, by="Institution", all.y=TRUE)

ECON_RAE_SUMMARY_NUM<-ECON_RAE_OUTPUT[,.N, InstitutionName][order(-N)]


#Datatable
datatable(ECON_REF_SUMMARY_NUM, rownames=F, filter='top',
          class='stripe', options=list(pageLength=100, dom='tp'))
datatable(ECON_RAE_SUMMARY_NUM, rownames=F, filter='top',
          class='stripe', options=list(pageLength=100, dom='tp'))

####################################### OUTPUT ##########################################
#  ------- FIRST PAGE ------------
p2a <- ggplot(ECON_REF_OUTPUT[First_page!=0], aes(Institution_name, First_page, color=Institution_name))
p2a + geom_boxplot(outlier.shape=NA) + #avoid plotting outliers twice
  geom_jitter(position=position_jitter(width=.1, height=0))+
  ggtitle("REF - First page of an output after removing outliers")+
  xlab("") +
  ylab("First Page nr") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1),legend.position = "none",
        plot.title = element_text(hjust =0.5, vjust=2.12, size=16))

ECON_REF_OUTPUT$First_page_trial<-as.factor(ECON_REF_OUTPUT$First_page_trial)

p2b <- ggplot(ECON_REF_OUTPUT[First_page!=0], aes(x=First_page_trial, fill=Institution_name))
p2b + geom_bar(position = "dodge", stat="count")+ facet_wrap(~Institution_name)+ 
  xlab("Category")+
  ggtitle("REF - First page category after removing outliers")+
  scale_x_discrete(breaks=1:8,
                   labels=c("0-250","250-500","500-750","750-1000","1000-1250", "1250-1500","1500-1750","1750-2000"))+
  theme(legend.position = "none", 
        axis.text.x = element_text(angle = 90, hjust = 1),
        plot.title = element_text(hjust =0.5, vjust=2.12, size=16))

rm(p2a,p2b)

# ---------- CITATATION COUNT ---------
p1 <- ggplot(ECON_REF_OUTPUT, aes(Institution_name, Citation_count, color=Institution_name))
p1a<-p1 + geom_jitter(position=position_jitter(width=.05, height=0), size=0.8) +
  geom_boxplot(outlier.shape=NA, alpha=0.5) + #avoid plotting outliers twice
  theme(axis.text.x = element_text(angle = 90, hjust = 1),legend.position = "none")+
  ggtitle("REFF - Citation count Y SCALE UP TO 50") +
  ylim(0,50) + xlab("") +
  ylab("Citations count") +
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=12))

p1b<-p1 + geom_boxplot(outlier.shape=NA) + #avoid plotting outliers twice
  geom_jitter(position=position_jitter(width=.05, height=0))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1),legend.position = "none")+
  ggtitle("REF - Citation count") +
  xlab("") +
  ylab("Citations count") +
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=12))

multiplot(p1b,p1a, cols=2)
rm(p1, p1a, p1b)

# ---------- YEAR ------------

ECON_SUMMARY<-ECON_REF_OUTPUT[,(number=.N),by=c("Institution_name","Year")][order(-V1)]

ggplot(ECON_SUMMARY, aes(x = Institution_name, y=V1, fill = Year))+ 
  geom_bar(stat = "Identity", position=position_dodge())+theme_bw(base_size = 12) + theme(axis.text.x=element_text(angle=90,hjust=1)) +
  ggtitle("Number of submissions per year")+theme(plot.title = element_text(hjust = 0.5))+xlab("Institution name")+ylab('Number of Submissions')+
  guides(fill=guide_legend(title="year"))


# ---------- OTPUT TYPE ---------
#Labels
ECON_REF_OUTPUT$Output_type<-revalue(ECON_REF_OUTPUT$Output_type, c("A"="Authored book","B"="Edited book", "C"="Chapter in book","R"="Scholarly edition","D"="Journal article","E"="Conference contribution","U"="Working paper",
                                                                    "L"="Artefact","P"="Devices and products","I"="Performance","M"="Exhibition","F"="Patent/published patent application","J"="Composition","K"="Design","N"="Research report for external body",
                                                                    "O"="Confidential report (for external body)", "S"="Research data sets and databases", "G"="Software","H"="Website content","G"="Software","H"="Website content","Q"="Digital or visual media","T"="Other"))


ECON_SUMMARYa<-ECON_REF_OUTPUT[,(number=.N),by=c("Institution_name","Output_type")][order(-V1)]
ECON_SUMMARYa<- ECON_SUMMARYa %>%
  complete(Institution_name, Output_type, fill = list(V1 = 0)) #really nice trick to bake width of the bar the same


ggplot(ECON_SUMMARYa, aes(x = Institution_name, y=V1, fill = Output_type))+ 
  geom_bar(stat = "Identity", width=0.7, position=position_dodge(0.6))+theme_bw(base_size = 12) + theme(axis.text.x=element_text(angle=90,hjust=1)) +
  ggtitle("Number of submissions - Output type")+theme(plot.title = element_text(hjust = 0.5))+xlab("Institution name")+ylab('Number of Submissions')+
  guides(fill=guide_legend(title="Output type"))


ECON_SUMMARYb<-ECON_REF_OUTPUT[,(number=.N),by=c("Institution_name","Year","Output_type")][order(-V1)]
ggplot(ECON_SUMMARYb, aes(x = Year, y=V1, fill=Output_type))+ 
  geom_bar(stat = "Identity")+theme_bw(base_size = 12) + theme(axis.text.x=element_text(angle=90,hjust=1)) +
  ggtitle("Number of submissions by output type")+
  theme(plot.title = element_text(hjust = 0.5))+
  xlab("Institution name")+
  ylab('Number of Submissions')+
  guides(fill=guide_legend(title="Output type"))+
  facet_wrap(~Institution_name)

rm(ECON_SUMMARYa)


#######
################################## RESULTS ########################################
############ RESULT  REF ##############

RES_ECONREF_RES_OUTPUT<-ECON_REF_RESULTS[Profile=='Outputs',
                                         c('Inst_name', 'FTE_cat_A','Four','Three','Two','One','Unclassified')]
#melting results
RES_ECONREF_RES_OUTPUT_MELTED<-melt(RES_ECONREF_RES_OUTPUT, 
                                    id.vars = "Inst_name", 
                                    measure.vars = c("Four","Three","Two","One","Unclassified"))

##### REF in %
g0 <- ggplot(RES_ECONREF_RES_OUTPUT_MELTED, aes(Inst_name, y=value))
g0<-g0 +  geom_bar(colour="black", aes(fill=variable), stat="identity", position = position_stack(reverse = TRUE)) +
  coord_flip() +
  theme(legend.position = "none") +
  ggtitle("REF Percentage of stars")+
  ylab("Share") +
  xlab("Institution name") +
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=12))


#### REF in %

colnames(ECON_REF_SUMMARY_NUM)<-c('Inst_name','Number_Sub')
ECON_table_number_of_works<-merge(RES_ECONREF_RES_OUTPUT,ECON_REF_SUMMARY_NUM)

ECON_REF_OUTPUT_N<-ECON_table_number_of_works[,.(Four=round(Four/100*Number_Sub),
                                                 Three=round(Three/100*Number_Sub),
                                                 Two=round(Two/100*Number_Sub),
                                                 One=round(One/100*Number_Sub),
                                                 Uncl=round(Unclassified/100*Number_Sub))
                                              ,Inst_name]
ECON_REF_OUTPUT_N[,':='(sum=Four+Three+Two+One+Uncl)]
rm(ECON_table_number_of_works)

#Melting data with number of records
ECON_REF_OUTPUT_N_MELTED<-melt(ECON_REF_OUTPUT_N, id.vars = "Inst_name", 
                               measure.vars = c("Four","Three","Two","One","Uncl","sum"))
colnames(ECON_REF_OUTPUT_N_MELTED)<-c('Inst_name','NumOfStars','Nr')

g<-ggplot(ECON_REF_OUTPUT_N_MELTED[NumOfStars!='sum'], aes(x =Inst_name, y=Nr, color=NumOfStars, fill=NumOfStars))
g<-g+geom_bar(stat = "Identity", position=position_dodge())+theme_bw(base_size = 12) + 
  theme(axis.text.x=element_text(angle=90,hjust=1)) + 
  ggtitle("Results by Institution - number")+
  theme(plot.title = element_text(hjust = 0.5))+
  xlab("Institution name")+
  ylab('Number')


multiplot(g0,g, cols=2)
rm(g0,g)
###########################################
################## RAE  ###################

RES_ECRAE_OUTPUT<-ECON_RAE_RESULTS[,c('Inst_name', 'FTE_cat_A','Four','Three','Two','One','Unclassified')]
#melting
RES_ECRAE_OUTPUT_MELTED<-melt(RES_ECRAE_OUTPUT, id.vars = "Inst_name", measure.vars = c("Four","Three","Two","One","Unclassified"))

g1 <- ggplot(RES_ECRAE_OUTPUT_MELTED, aes(Inst_name, y=value))
g1<- g1 +  geom_bar(colour="black", aes(fill=variable), stat="identity", position = position_stack(reverse = TRUE)) +
  coord_flip() +
  theme(legend.position = "none") +
  ggtitle("RAE Percentage of stars")+
  ylab("Share") +
  xlab("Institution name") +
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=12))


#####N 

colnames(ECON_RAE_SUMMARY_NUM)<-c('Inst_name','Number_Sub')
ECON_table_number_of_works<-merge(RES_ECRAE_OUTPUT,ECON_RAE_SUMMARY_NUM, by="Inst_name")#Now we have table with umber of works

ECON_RAE_OUTPUT_N<-ECON_table_number_of_works[,.(Four=round(Four/100*Number_Sub),
                                                 Three=round(Three/100*Number_Sub),
                                                 Two=round(Two/100*Number_Sub),
                                                 One=round(One/100*Number_Sub),
                                                 Uncl=round(Unclassified/100*Number_Sub))
                                              ,Inst_name]
ECON_RAE_OUTPUT_N[,':='(sum=Four+Three+Two+One+Uncl)]
rm(ECON_table_number_of_works)

ECON_RAE_OUTPUT_N_MELTED<-melt(ECON_RAE_OUTPUT_N, id.vars = "Inst_name", 
                               measure.vars = c("Four","Three","Two","One","Uncl","sum"))
colnames(ECON_RAE_OUTPUT_N_MELTED)<-c('Inst_name','NumOfStars','Nr')

g2<-ggplot(ECON_RAE_OUTPUT_N_MELTED[NumOfStars!='sum'], aes(x =Inst_name, y=Nr, color=NumOfStars, fill=NumOfStars))
g2<-g2+geom_bar(stat = "Identity", position=position_dodge())+theme_bw(base_size = 12) + 
  theme(axis.text.x=element_text(angle=90,hjust=1)) + 
  ggtitle("Results by Institution - number")+
  theme(plot.title = element_text(hjust = 0.5))+
  xlab("Institution name")+
  ylab('Number')

multiplot(g1,g2, cols=2)



################## REF & RAE COMPARISON ##############

REF_RAE_STARS_MERGED<-merge(RES_ECONREF_RES_OUTPUT_MELTED,RES_ECRAE_OUTPUT_MELTED, by=c("Inst_name","variable"), all=TRUE)
colnames(REF_RAE_STARS_MERGED)<-c("Inst_name","star","REF","RAE")
REF_RAE_STARS_MERGED_MELT<-melt(REF_RAE_STARS_MERGED, id.vars=c("Inst_name","star"), measure.vars = c("REF","RAE"))

C_STAR_RAE <- ggplot(REF_RAE_STARS_MERGED_MELT, aes(x=star, y=value, fill=variable))
C_STAR_RAE + geom_bar(colour="black",  stat="identity", position = "dodge") +
  theme(legend.position = "top") + facet_wrap(~Inst_name) +
  ggtitle("Economy & Econometrics - RAE vs REF")+
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=12))


ECON_REF_RESULTS<-as.data.table(ECON_REF_RESULTS)
ECON_REF_RESULTS_OVERALL<-ECON_REF_RESULTS[Profile=="Overall",.(Inst_name,Four,Three,Two,One,Unclassified),]
ECON_REF_RESULTS_OUTPUTS<-ECON_REF_RESULTS[Profile=="Outputs",.(Inst_name,Four,Three,Two,One,Unclassified),]

#melting data in order to present OVERALL RESULTS on a plot
#Search for help for function melt and reshape
ECON_REF_RES_OVERALL_MELTED<-melt(ECON_REF_RESULTS_OVERALL, id.vars = "Inst_name", measure.vars = c("Four","Three","Two","One","Unclassified"))
colnames(ECON_REF_RES_OVERALL_MELTED)<-c('Inst_name','NumOfStars','Percent')

ggplot(ECON_REF_RES_OVERALL_MELTED, aes(x = Inst_name, y=Percent, color = NumOfStars, fill=NumOfStars))+
  geom_bar(color="black",stat = "Identity")+theme_bw(base_size = 12) + 
  theme(axis.text.x=element_text(angle=90,hjust=1)) + ggtitle("OVERALL Results by Institution")+theme(plot.title = element_text(hjust = 0.5))+
  xlab("Institution name")+ylab('%')

#melting outputs

ECON_REF_RES_OUTPUTS_MELTED<-melt(ECON_REF_RESULTS_OUTPUTS, id.vars = "Inst_name", measure.vars = c("Four","Three","Two","One","Unclassified"))
colnames(ECON_REF_RES_OUTPUTS_MELTED)<-c('Inst_name','NumOfStars','Percent')


# #NUMBER OF RECORDS GROUPED BY EVRY VAR
# ECON_REF_COUNTED<-ECON_REF_OUTPUT[,.N, by=c("Institution_name","First_page_trial","Output_type","Publisher","Year","Number_of_additional_authors")]

########################################################################################################################
