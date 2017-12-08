
############################################# CORRELATION #############################################

### ------------- Income 
#ADDING INCOME

ECON_REF_ResearchIncome<-as.data.table(read_excel(path="Econometrics_Economy/REF_Economics and_Econometrics.xlsx", sheet = "ResearchIncome"))
colnames(ECON_REF_ResearchIncome)

colnames(ECON_REF_ResearchIncome) <- gsub(" ", "_", colnames(ECON_REF_ResearchIncome))
ECON_REF_ResearchIncome<-ECON_REF_ResearchIncome[,c("Institution_name", "Source","Income_for_2008-09",
                                                    "Income_for_2009-10","Income_for_2010-11",
                                                    "Income_for_2011-12","Income_for_2012-13")]

colnames(ECON_REF_ResearchIncome)<-c("Institution_name", "Source","Year2008","Year2009","Year2010","Year2011","Year2012")
ECON_REF_ResearchIncome[,':='(TotIncome=Year2008+Year2009+Year2010+Year2011+Year2012)]

IncomeByInst<-ECON_REF_ResearchIncome[,.(Income=round(sum(TotIncome)/1000)),
                                      by="Institution_name"][order(-Income)]

##### CHECKING THE CORRELATION FOR AN INCOME
t<-merge(ECON_REF_RESULTS_OUTPUTS,IncomeByInst, by.x='Inst_name', by.y='Institution_name', all.x=TRUE)
#Test t for Income
cor(t$Income, t$Four, method='spearman')

#plot 4 sar
g1<-ggplot(t, aes(x = Four, y=Income, color=Inst_name, size=Income)) 
g1<-g1+ geom_point() +
  ggtitle("Correlation between total income in 5 years and 4* Outcome")+
  xlab("FourStar") +
  ylab("Income in touands") +
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=12))+
  theme(legend.position="none")+
  labs(color="Institution name")
#plot 3 star
g2<-ggplot(t, aes(x = Three, y=Income, color=Inst_name, size=Income))
g2<-g2+geom_point() +
  ggtitle("Correlation between total income in 5 years and 3* Outcome")+
  xlab("ThreeStar") +
  ylab("Income in touands") +
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=12))+
  theme(legend.position="none")+
  labs(color="Institution name")
#plot 2 star
g3<-ggplot(t, aes(x = Two, y=Income, color=Inst_name, size=Income))
g3<-g3+geom_point() +
  ggtitle("Correlation between total income in 5 years and 2* Outcome")+
  xlab("TwoStar") +
  ylab("Income in touands") +
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=12))+
  theme(legend.position="none")+
  labs(color="Institution name")

#plot 1 star
g4<-ggplot(t, aes(x = One, y=Income, color=Inst_name, size=Income))
g4<-g4+geom_point() +
  ggtitle("Correlation between total income in 5 years and 1* Outcome")+
  xlab("OneStar") +
  ylab("Income in touands") +
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=12))+
  theme(legend.position="none")+
  labs(color="Institution name")

multiplot(g1,g2,g3,g4, cols=2)

rm(g1,g2,g3,g4)

#Grouping influence by source

IncomeByInstSource<-ECON_REF_ResearchIncome[,.(Income=sum(TotIncome)/1000),
                                            by=c("Institution_name","Source")][order(-Income)]
IncomeByInstSour<-merge(IncomeByInstSource,IncomeByInst, by="Institution_name", all.x=T)
#Table IncomeByInst we created earlier; we want to knowe the %
colnames(IncomeByInstSour)<-c("Institution_name","Source", "Income", "Total")
IncomeByInstSour<-IncomeByInstSour[,':='(perc=Income/Total)]

#### ***Visualization***
ggplot(IncomeByInstSour, aes(Institution_name, perc)) +
  geom_bar(colour="black", aes(fill=Source), stat="identity", position = position_stack(reverse = TRUE)) +
  coord_flip() +
  theme(legend.position = "top") +
  ggtitle("REF Percentage of stars")+
  ylab("% of income") +
  xlab("Institution name") +
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=12))

#Group analysis
#Creating datatable grouped by source
IncomeByInstSour$Source<-as.factor(IncomeByInstSour$Source)
##### PLOT OF INCOME PER SOURCE
ggplot(IncomeByInstSource, aes(x = Institution_name, y=Income, fill=Source))+ 
  geom_bar(colour="black", stat = "Identity")+theme_bw(base_size = 12)+
  ggtitle("Total income per University by source")+
  xlab("University") +
  ylab("Income") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1),
        plot.title = element_text(hjust =0.5, vjust=2.12, size=16))

ggplot(ECON_REF_ResearchIncome, aes(x =Source, y=TotIncome, colour = Institution_name))+ 
  geom_point(alpha=0.5)+ geom_jitter()+
  ggtitle("Total income by source")+
  xlab("Source") +
  ylab("Income") +
  scale_y_continuous(limits=c(0, 1000000))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1),
        plot.title = element_text(hjust =0.5, vjust=2.12, size=16))

IncomeByInstSource<- IncomeByInstSource %>%#trick
  complete(Institution_name, Source, fill = list(Income = 0))

IncomeByInstSource<-as.data.table(IncomeByInstSource)
IncomeByInstSource$Institution_name<-as.factor(IncomeByInstSource$Institution_name)
IncomeByInstSource$Source<-as.factor(IncomeByInstSource$Source)
IncomeByInstSource$Income<-as.numeric(IncomeByInstSource$Income)

############ HEAT MAP #############
ggplot(IncomeByInstSource, aes(Source, Institution_name)) +
  geom_tile(aes(fill = Income), color = "white") +
  scale_fill_gradient(low = "white", high = "steelblue") +
  ylab("Institution") +
  xlab("Source") +
  theme(legend.title = element_text(size = 10),
        legend.text = element_text(size = 12),
        plot.title = element_text(size=12),
        axis.title=element_text(size=12,face="bold"),
        axis.text.x = element_text(angle = 45, hjust = 1))+
  labs(fill = "Income")


# ________ Correlation ________ #
#Corelation betweeen 4 star and % of total income from particular source (only above 10 obs for a University)

levels(IncomeByInstSour$Source)
IncomeBISResCoun<-merge(ECON_REF_RESULTS_OUTPUTS,IncomeByInstSour[Source==levels(IncomeByInstSour$Source)[2]],
                        by.x='Inst_name', by.y='Institution_name', all.y=TRUE)

IncomeEUGovBody<-merge(ECON_REF_RESULTS_OUTPUTS,IncomeByInstSour[Source==levels(IncomeByInstSour$Source)[3]],
                       by.x='Inst_name', by.y='Institution_name', all.y=TRUE)

IncomeEUIndustry<-merge(ECON_REF_RESULTS_OUTPUTS,IncomeByInstSour[Source==levels(IncomeByInstSour$Source)[4]],
                        by.x='Inst_name', by.y='Institution_name', all.y=TRUE)

IncomeEUother<-merge(ECON_REF_RESULTS_OUTPUTS,IncomeByInstSour[Source==levels(IncomeByInstSour$Source)[5]],
                     by.x='Inst_name', by.y='Institution_name', all.y=TRUE)

IncomeNonEUcharity<-merge(ECON_REF_RESULTS_OUTPUTS,IncomeByInstSour[Source==levels(IncomeByInstSour$Source)[7]],
                          by.x='Inst_name', by.y='Institution_name', all.y=TRUE)

IncomeNonEUothers<-merge(ECON_REF_RESULTS_OUTPUTS,IncomeByInstSour[Source==levels(IncomeByInstSour$Source)[9]],
                         by.x='Inst_name', by.y='Institution_name', all.y=TRUE)

IncomeOtherSource<-merge(ECON_REF_RESULTS_OUTPUTS,IncomeByInstSour[Source==levels(IncomeByInstSour$Source)[10]],
                         by.x='Inst_name', by.y='Institution_name', all.y=TRUE)

IncomeUKgov<-merge(ECON_REF_RESULTS_OUTPUTS,IncomeByInstSour[Source==levels(IncomeByInstSour$Source)[11]],
                   by.x='Inst_name', by.y='Institution_name', all.y=TRUE)

IncomeUKindustry<-merge(ECON_REF_RESULTS_OUTPUTS,IncomeByInstSour[Source==levels(IncomeByInstSour$Source)[12]],
                        by.x='Inst_name', by.y='Institution_name', all.y=TRUE)

IncomeUKcharity<-merge(ECON_REF_RESULTS_OUTPUTS,IncomeByInstSour[Source==levels(IncomeByInstSour$Source)[13]],
                       by.x='Inst_name', by.y='Institution_name', all.y=TRUE)

IncomeUKcharitiesO<-merge(ECON_REF_RESULTS_OUTPUTS,IncomeByInstSour[Source==levels(IncomeByInstSour$Source)[14]],
                          by.x='Inst_name', by.y='Institution_name', all.y=TRUE)


#### CORRELATION with percentage of income
cor(IncomeBISResCoun$Four, IncomeBISResCoun$perc)#No
cor(IncomeEUGovBody$Four, IncomeEUGovBody$perc)#No
#cor(IncomeEUIndustry$Four, IncomeEUIndustry$perc)#No, not enough obs
cor(IncomeEUother$Four, IncomeEUother$perc)#Not enough obs
cor(IncomeNonEUcharity$Four, IncomeNonEUcharity$perc)#No
cor(IncomeNonEUothers$Four, IncomeNonEUothers$perc)#No
cor(IncomeOtherSource$Four, IncomeOtherSource$perc)#No small negative
cor(IncomeUKgov$Four, IncomeUKgov$perc)#No
cor(IncomeUKindustry$Four, IncomeUKindustry$perc)#No
#two charities ?? what differenece?
cor(IncomeUKcharity$Four, IncomeUKcharity$perc)#No
cor(IncomeUKcharitiesO$Four,IncomeUKcharitiesO$perc)#No


#Correlation with Income in amount
cor(IncomeBISResCoun$Four, IncomeBISResCoun$Income)#Weak
cor(IncomeEUGovBody$Four, IncomeEUGovBody$Income)#High- 0,79
#cor(IncomeEUIndustry$Four, IncomeEUIndustry$Income)#No, not enough obs
cor(IncomeEUother$Four, IncomeEUother$Income)#Yes, but only 10 obs 0,69
cor(IncomeNonEUcharity$Four, IncomeNonEUcharity$Income)#No
cor(IncomeNonEUothers$Four, IncomeNonEUothers$Income)#Medium 0,46
cor(IncomeOtherSource$Four, IncomeOtherSource$Income)#No
cor(IncomeUKgov$Four, IncomeUKgov$Income)#Medium
cor(IncomeUKindustry$Four, IncomeUKindustry$Income)#No
#two charities ?? what differenece?
cor(IncomeUKcharity$Four, IncomeUKcharity$Income)#No
cor(IncomeUKcharitiesO$Four,IncomeUKcharitiesO$Income)#Yes,0.64

####So we should only cosider income in amount; no corr in %

########## GROUPING SOURCES
### Industry Transformation

GroupedIndusIncome<-IncomeByInstSour[Source=="Non-EU industry, commerce and public corporations"|
                                       Source=="EU industry, commerce and public corporations"|
                                       Source=="UK industry, commerce and public corporations",
                                     .(Income=sum(Income)),by=c("Institution_name")]

GroupedIndusIncome<-merge(GroupedIndusIncome,IncomeByInst, by="Institution_name",all.y=T)
colnames(GroupedIndusIncome)<-c("Institution_name","IncomeIndustry","Total")

GroupedIndusIncome<-GroupedIndusIncome[,':='(perc=IncomeIndustry/Total)]

IncomeINDUSTRY<-merge(ECON_REF_RESULTS_OUTPUTS,GroupedIndusIncome,
                      by.x='Inst_name', by.y='Institution_name', all.y=TRUE)
IncomeINDUSTRY[is.na(IncomeINDUSTRY$perc)]<-0
####

#Let's chec for all the industry
cor(IncomeINDUSTRY$Four, IncomeINDUSTRY$perc)#no
cor(IncomeINDUSTRY$Four, IncomeINDUSTRY$IncomeIndustry)#yes - 0,59

### Governmental transformation

GroupedGovIncome<-IncomeByInstSour[Source=="EU government bodies"|
                                     Source=="UK central government bodies, local authorities, health and hospital authorities",
                                   .(Income=sum(Income)),by=c("Institution_name")]

GroupedGovIncome<-merge(GroupedGovIncome,IncomeByInst, by="Institution_name",all.y=T)

colnames(GroupedGovIncome)<-c("Institution_name","IncomeGov", "Total")
GroupedGovIncome<-GroupedGovIncome[,':='(perc=IncomeGov/Total)]

IncomeGover<-merge(ECON_REF_RESULTS_OUTPUTS,GroupedGovIncome,
                   by.x='Inst_name', by.y='Institution_name', all.y=TRUE)

IncomeGover[is.na(IncomeGover$perc)]<-0

cor(IncomeGover$Four, IncomeGover$perc)#no
cor(IncomeGover$Four, IncomeGover$Income)#yes - 0,62

### BIS TRANSFORMATION

GroupedBISIncome<-IncomeByInstSour[Source=="BIS Research Councils income-in-kind"|
                                     Source=="BIS Research Councils, Royal Society, British Academy and Royal Society of Edinburgh",
                                   .(Income=sum(Income)),by=c("Institution_name")]


GroupedBISIncome<-merge(GroupedBISIncome,IncomeByInst, by="Institution_name",all.y=T)

colnames(GroupedBISIncome)<-c("Institution_name","IncomeBIS", "Total")
GroupedBISIncome<-GroupedBISIncome[,':='(perc=IncomeBIS/Total)]

IncomeBIS<-merge(ECON_REF_RESULTS_OUTPUTS,GroupedBISIncome,
                 by.x='Inst_name', by.y='Institution_name', all.y=TRUE)
IncomeBIS[1]<-0

cor(IncomeBIS$Four, IncomeBIS$perc)#no
cor(IncomeBIS$Four, IncomeBIS$Income)#small 0,33


#*#*#*#*#*#*#*#**#*#

#Merging for ploting withing subgroups

rm(mergedINCOME)
mergedINCOME<-merge(IncomeGover, IncomeBIS[,c(1,7)],by="Inst_name", all.x=T)
str(mergedINCOME)
mergedINCOME<-merge(mergedINCOME, IncomeINDUSTRY[Inst_name!="0",c(1,7)],by="Inst_name",all.x=T)
mergedINCOME[is.na(mergedINCOME)]<-0
mergedINCOME<-mergedINCOME[,c('Inst_name', 'Four',  'IncomeGov', 'Total', 'IncomeBIS', 'IncomeIndustry')]
mergedINCOMEcast<-melt(mergedINCOME,id.vars = c("Inst_name","Four"), 
                       measure.vars = c('IncomeGov', 'Total', 'IncomeBIS', 'IncomeIndustry'))
#*#*# Visualization *#*#*#
ggplot(mergedINCOMEcast, aes(x=Four, y=value, colour=Inst_name, size=value))+ 
  geom_point()+
  facet_wrap(~variable)+
  ggtitle("Total income by grouped source")+
  xlab("% of Four star") +
  ylab("Income in thousands") +
  scale_y_continuous(limits=c(0, 30000))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1),
        plot.title = element_text(hjust =0.5, vjust=2.12, size=16))

##############
# ----------------OUTPUT vs 4 star

# Percentage share

InstOutp<-ECON_REF_OUTPUT[,(number=.N),by=c("Institution_name","Output_type")][order(-V1)]
Inst<-ECON_REF_OUTPUT[,(number=.N),by=c("Institution_name")][order(-V1)]

InstOutput<-merge(InstOutp,Inst, by="Institution_name", all.x=T)
colnames(InstOutput)<-c("Institution_name","Output_type", "number", "total")
InstOutput<-InstOutput[,':='(perc=number/total)]

# VISUALIZATION
c <- ggplot(InstOutput, aes(Institution_name,  perc))
c + geom_bar(colour="black", aes(fill=Output_type), stat="identity", position = position_stack(reverse = TRUE)) +
  coord_flip() +
  theme(legend.position = "top") +
  ggtitle("REF Percentage of stars - Output type")+
  ylab("Share") +
  xlab("Institution name") +
  labs(fill="Output type")+
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=12))

#Corelation betweeen 4 star and other output than journal?
levels(InstOutput$Output_type)
OutWorkPaper<-merge(ECON_REF_RESULTS_OUTPUTS,InstOutput[Output_type=="Working paper"],
                    by.x='Inst_name', by.y='Institution_name', all.x=TRUE)
OutWorkPaper[is.na(OutWorkPaper)]<-0

OutChapter<-merge(ECON_REF_RESULTS_OUTPUTS,InstOutput[Output_type=="Chapter in book"],
                  by.x='Inst_name', by.y='Institution_name', all.x=TRUE)
OutChapter[is.na(OutChapter)]<-0

OutBook<-merge(ECON_REF_RESULTS_OUTPUTS,InstOutput[Output_type=="Authored book"],
               by.x='Inst_name', by.y='Institution_name', all.x=TRUE)
OutBook[is.na(OutBook)]<-0

#IS THERE OUTPUT CORELATIONS??
cor(OutWorkPaper$Four, OutWorkPaper$perc)#small cor
cor(OutChapter$Four, OutChapter$perc)#No
cor(OutBook$Four, OutBook$perc)#No 

cor(OutWorkPaper$Four, OutWorkPaper$number)#yes - 0.6
cor(OutChapter$Four, OutChapter$number)#No
cor(OutBook$Four, OutBook$number)#No

##------------------ FTE A CAT

f<-ECON_REF_RESULTS[Profile=="Outputs",.(Inst_name,Four,Three,Two,One,Unclassified, FTE_cat_A),]

#plot
ggplot(f, aes(x = Four, y=FTE_cat_A, color=Inst_name))+ 
  geom_point()+
  ggtitle("Correlation between FTEcatA and Four Star Outcome")+
  scale_x_continuous(limits=c(0, 100))+
  scale_y_continuous(limits=c(0, 100))+
  xlab("FourStar") +
  ylab("FTEcatStaff") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1),
        plot.title = element_text(hjust =0.5, vjust=2.12, size=16))

cor(f$FTE_cat_A, f$Four)#There is tendency but with quite high residuals
cor(f$FTE_cat_A, f$Four)

# ----- PUBLISHER ------- #

summary(ECON_REF_OUTPUT)
#Not enough data in that case
