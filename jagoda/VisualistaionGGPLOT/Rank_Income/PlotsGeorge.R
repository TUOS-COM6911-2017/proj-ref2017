setwd("/Users/gosc/Desktop/TEAM_PROJECT/George")
getwd()


library(readxl)
library(data.table)
library(ggplot2)
library(plyr)
library(dplyr)
library(reshape)
library(magrittr)

######## Importing data ##########


RankBiolScience<-as.data.table(read_excel(path="RankJournal.xlsx", sheet="Biology"))
RankPubhealth<-as.data.table(read_excel(path="RankJournal.xlsx", sheet="Publichealth"))
RankPhysics<-as.data.table(read_excel(path="RankJournal.xlsx", sheet="Physics"))
RankComputerScience<-as.data.table(read_excel(path="RankJournal.xlsx", sheet="ComputerScience"))
RankAeroMechanic<-as.data.table(read_excel(path="RankJournal.xlsx", sheet="Aeronautical"))
RankEconomics<-as.data.table(read_excel(path="RankJournal.xlsx", sheet="Economics"))
RankAntropology<-as.data.table(read_excel(path="RankJournal.xlsx", sheet="Antropology"))
RankEducation<-as.data.table(read_excel(path="RankJournal.xlsx", sheet="Education"))
RankPhilosophy<-as.data.table(read_excel(path="RankJournal.xlsx", sheet="Philosophy"))
RankCommunication<-as.data.table(read_excel(path="RankJournal.xlsx", sheet="Communication"))
Dict<-as.data.table(read_excel(path="RankJournal.xlsx", sheet="DICT"))

cor(RankComputerScience$AvgRank, RankComputerScience$FourStar)

colnames(RankAntropology)

d1<-RankBiolScience[,.(UKPRN, AvgRank, FourStar, category="Biology")]
d2<-RankPubhealth[,.(UKPRN, AvgRank, FourStar, category="Publichealth")]
d3<-RankPhysics[,.(UKPRN, AvgRank, FourStar, category="Physics")]
d4<-RankComputerScience[,.(UKPRN, AvgRank, FourStar, category="ComputerScience")]
d5<-RankAeroMechanic[,.(UKPRN, AvgRank, FourStar, category="Aeronautical")]
d6<-RankEconomics[,.(UKPRN, AvgRank, FourStar, category="Economics")]
d7<-RankAntropology[,.(UKPRN, AvgRank, FourStar, category="Antropology")]
d8<-RankEducation[,.(UKPRN, AvgRank, FourStar, category="Education")]
d9<-RankPhilosophy[,.(UKPRN, AvgRank, FourStar, category="Philosophy")]
d10<-RankCommunication[,.(UKPRN, AvgRank, FourStar, category="Communication")]

#Changing data types
Table<-as.data.table(rbind(d1,d2,d3,d4,d5,d6,d7,d8,d9,d10))
rm(d1,d2,d3,d4,d5,d6,d7,d8,d9,d10)

Table$FourStar<-as.numeric(Table$FourStar)
Table$category<-as.factor(Table$category)
Table$UKPRN<-as.factor(Table$UKPRN)
Dict$UKPRN<-as.factor(Dict$UKPRN)


#Ploting
Table<-merge(Table, Dict, by="UKPRN")
Table$Name<-as.factor(Table$Name)
Table<-Table[order(Name),]


plot <- ggplot(Table, aes(y=FourStar, x=AvgRank, color=category))
pl1<-plot + geom_point(size=0.5, alpha=0.5) + 
  geom_smooth(formula = y ~ x, se=FALSE)+
 # geom_smooth(alpha=0.5)+
  theme(axis.text.x = element_text(angle = 90, 
                                   hjust = 1),legend.position = "bottom")+
  ggtitle("Avg journal ranking vs. 4* Output per category") +
  ylim(0,80) + xlab("") +
  ylab("") +
  scale_y_continuous(limits=c(0, 80))+#scale without one outlier
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10))

plot2 <- ggplot(Table, aes(y=FourStar, x=AvgRank))
pl2<-plot2 + geom_point(size=0.5, alpha=0.5) + 
  geom_smooth(formula = y ~ x)+
  # geom_smooth(alpha=0.5)+
  theme(axis.text.x = element_text(angle = 90, 
                                   hjust = 1),legend.position = "bottom")+
  ggtitle("Average journal ranking vs. 4* Output in total") +
  ylim(0,80) + xlab("") +
  ylab("") +
  scale_y_continuous(limits=c(0, 80))+#scale without one outlier
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10))

plot3 <- ggplot(Table, aes(y=FourStar, x=category, color=category))
pl3<-plot3 + geom_boxplot()+geom_jitter(alpha=0.5)+ggtitle("Category vs. 4*") +
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10),
                                  axis.text.x = element_text(angle = 90, hjust = 1),
        legend.position = "none")

  
plot4 <- ggplot(Table, aes(y=AvgRank, x=category, color=category))
pl4<-plot4 + geom_boxplot()+geom_jitter(alpha=0.5)+ggtitle("Category vs. Avg ranking of journal*") +
    theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10),
                                    axis.text.x =element_text(angle = 90, hjust = 1),
          legend.position="none")
 
multiplot(pl1,pl2, cols=2) 
 multiplot(pl3,pl4, cols=2) 

#creating University filtr

plot5 <- ggplot(Table, aes(y=AvgRank, x=Name))
plot5 + geom_boxplot()+geom_jitter()+ggtitle("University vs. AvgRank") +
   theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=12),
         axis.text.x =element_text(angle = 90, hjust = 1),
         legend.position="none")
 
plot6a <- ggplot(Table[1:109], aes(y=FourStar, x=Name, color=Name))
plot6a<-plot6a + geom_boxplot() +
  scale_y_continuous(limits=c(0, 60))+
  ylab("")+
  xlab("")+
  theme(plot.title = element_text(hjust =0.5, vjust=3.12, size=10),
        axis.text.x =element_text(angle = 90, hjust = 1, size=6),
        legend.position="none")

plot6b <- ggplot(Table[110:223], aes(y=FourStar, x=Name, color=Name))
plot6b<-plot6b + geom_boxplot()+
  scale_y_continuous(limits=c(0, 60))+
  ylab("")+
  xlab("")+
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=12),
        axis.text.x =element_text(angle = 90, hjust = 1, size=6),
        legend.position="none")

plot6c <- ggplot(Table[224:345], aes(y=FourStar, x=Name, color=Name))
plot6c<-plot6c + geom_boxplot()+
  scale_y_continuous(limits=c(0, 60))+
  ylab("")+
  xlab("")+
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=12),
        axis.text.x =element_text(angle = 90, hjust = 1, size=6),
        legend.position="none")

plot6d <- ggplot(Table[346:455], aes(y=FourStar, x=Name, color=Name))
plot6d<-plot6d + geom_boxplot()+
  scale_y_continuous(limits=c(0, 60))+
  ylab("")+
  xlab("")+
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=12),
        axis.text.x =element_text(angle = 90, hjust = 1, size=6),
        legend.position="none")

multiplot(plot6a,plot6b, plot6c, plot6d, cols=2)


#Correlationtable
CorTable<-Table[, .(Correlation=round(cor(FourStar, AvgRank),2)), by = category]
c<-Table[, .(Correlation=round(cor(FourStar, AvgRank),2),category="Total")]
CorTable<-as.data.table(rbind(CorTable,c))


 ####### CITATIONS ###########
 
CitIncBiolScience<-as.data.table(read_excel(path="CitatIncome.xlsx", sheet="Biology"))
CitIncPubhealth<-as.data.table(read_excel(path="CitatIncome.xlsx", sheet="Publichealth"))
CitIncPhysics<-as.data.table(read_excel(path="CitatIncome.xlsx", sheet="Physics"))
CitIncComputerScience<-as.data.table(read_excel(path="CitatIncome.xlsx", sheet="ComputerScience"))
CitIncAeroMechanic<-as.data.table(read_excel(path="CitatIncome.xlsx", sheet="Aeronautical"))
CitIncEconomics<-as.data.table(read_excel(path="CitatIncome.xlsx", sheet="Economics"))
CitIncAntropology<-as.data.table(read_excel(path="CitatIncome.xlsx", sheet="Antropology"))
CitIncEducation<-as.data.table(read_excel(path="CitatIncome.xlsx", sheet="Education"))
CitIncPhilosophy<-as.data.table(read_excel(path="CitatIncome.xlsx", sheet="Philosophy"))
CitIncCommunication<-as.data.table(read_excel(path="CitatIncome.xlsx", sheet="Communication"))

 colnames(CitIncComputerScience)
 #TwoOneStar, FourStar, AvgCitatationSub
 d1<-CitIncBiolScience[,.(TwoOneStar, FourStar, AvgCitatationSub, category="Biology")]
 d2<-CitIncPubhealth[,.(TwoOneStar, FourStar, AvgCitatationSub, category="Publichealth")]
 d3<-CitIncPhysics[,.(TwoOneStar, FourStar, AvgCitatationSub, category="Physics")]
 d4<-CitIncComputerScience[,.(TwoOneStar, FourStar, AvgCitatationSub, category="ComputerScience")]
 d5<-CitIncEconomics[,.(TwoOneStar, FourStar, AvgCitatationSub, category="Economics")]

 #Changing data types
 Table<-as.data.table(rbind(d1,d2,d3,d4,d5))
 rm(d1,d2,d3,d4,d5)
 colnames(Table)

 Table$category<-as.factor(Table$category)

 plotC <- ggplot(Table, aes(y=FourStar, x=AvgCitatationSub, color=category))
 plotC<-plotC + geom_point(size=0.5, alpha=0.5) + 
   #geom_smooth(formula = y ~ x, se=FALSE)+
    geom_smooth(alpha=0.5)+
   theme(axis.text.x = element_text(angle = 90, 
                                    hjust = 1),legend.position = "bottom")+
   ggtitle("Avg nr of citation per submission vs. 4* output") +
   ylim(0,80) + xlab("") +
   ylab("") +
   scale_y_continuous(limits=c(0, 80))+#scale without one outlier
   theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=8))

 plotCTot <- ggplot(Table, aes(y=FourStar, x=AvgCitatationSub))
 plotCTot<-plotCTot + geom_point(size=0.5, alpha=0.5) + 
   #geom_smooth(formula = y ~ x, se=FALSE)+
   geom_smooth(alpha=0.5)+
   theme(axis.text.x = element_text(angle = 90, 
                                    hjust = 1),legend.position = "bottom")+
   ggtitle("Average nr of citation per submission vs. 4* output") +
   ylim(0,80) + xlab("") +
   ylab("") +
   scale_y_continuous(limits=c(0, 80))+#scale without one outlier
   theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=8))
 
 multiplot(plotC,plotCTot, cols=2)
 
 plotC2 <- ggplot(Table, aes(y=AvgCitatationSub, x=category, color=category))
 plotC2+ geom_boxplot()+geom_jitter(alpha=0.5)+ggtitle("Avg. number citations per submission") +
   ylab("Number")+
   theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10),
         axis.text.x =element_text(angle = 90, hjust = 1),
         legend.position="none")
 
 CorTableCit<-Table[, .(Correlation=round(cor(FourStar, AvgCitatationSub),2)), by = category]
 c<-Table[, .(Correlation=round(cor(FourStar, AvgCitatationSub),2),category="Total")]
 CorTableCit<-as.data.table(rbind(CorTable,c)) #good

 
 ############ Income
 
 d1<-CitIncBiolScience[,.(TwoOneStar, FourStar, IncomeSubmission, category="Biology")]
 d2<-CitIncPubhealth[,.(TwoOneStar, FourStar, IncomeSubmission, category="Publichealth")]
 d3<-CitIncPhysics[,.(TwoOneStar, FourStar, IncomeSubmission, category="Physics")]
 d4<-CitIncComputerScience[,.(TwoOneStar, FourStar, IncomeSubmission, category="ComputerScience")]
 d5<-CitIncAeroMechanic[,.(TwoOneStar, FourStar, IncomeSubmission, category="ComputerScience")]
 d6<-CitIncEconomics[,.(TwoOneStar, FourStar, IncomeSubmission, category="Economics")]
 d7<-CitIncAntropology[,.(TwoOneStar, FourStar, IncomeSubmission, category="Antropology")]
 d8<-CitIncEducation[,.(TwoOneStar, FourStar, IncomeSubmission, category="Education")]
 d9<-CitIncPhilosophy[,.(TwoOneStar, FourStar, IncomeSubmission, category="Philosophy")]
 d10<-CitIncCommunication[,.(TwoOneStar, FourStar, IncomeSubmission, category="Communication")]
 
 
 Table<-as.data.table(rbind(d1,d2,d3,d4,d5,d6,d7,d8,d9,d10))
 rm(d1,d2,d3,d4,d5,d6,d7,d8,d9,d10)
 
 Table$FourStar<-as.numeric(Table$FourStar)
 Table$category<-as.factor(Table$category)
 Table$IncomeSubmission<-as.numeric(Table$IncomeSubmission)

 plotI <- ggplot(Table, aes(y=FourStar, x=IncomeSubmission, color=category))
 plotI<-plotI + geom_point(size=0.5, alpha=0.5) + 
   #geom_smooth(formula = y ~ x, se=FALSE)+
   geom_smooth(alpha=0.3)+
   theme(axis.text.x = element_text(angle = 90, 
                                    hjust = 1),legend.position = "bottom")+
   ggtitle("Avg. income per submission in millions vs. 4* output") +
   ylim(0,80) + xlab("") +
   ylab("") +
   scale_y_continuous(limits=c(0, 80))+#scale without one outlier
   theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=8))
 
 plotITot <- ggplot(Table, aes(y=FourStar, x=IncomeSubmission))
 plotITot<-plotITot + geom_point(size=0.5, alpha=0.5) + 
   #geom_smooth(formula = y ~ x, se=FALSE)+
   geom_smooth(alpha=0.5)+
   theme(axis.text.x = element_text(angle = 90, 
                                    hjust = 1),legend.position = "bottom")+
   ggtitle("Avg. income per submission in millions vs. 4* output") +
   ylim(0,80) + xlab("") +
   ylab("") +
   scale_y_continuous(limits=c(0, 80))+#scale without one outlier
   theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=8))
 
 multiplot(plotI,plotITot, cols=2)
 
 plotI2 <- ggplot(Table, aes(y=IncomeSubmission, x=category, color=category))
 plotI2+ geom_boxplot()+geom_jitter(alpha=0.5)+ggtitle("Avg. volume of income per submission in millions") +
   ylab("Number")+
   theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10),
         axis.text.x =element_text(angle = 90, hjust = 1),
         legend.position="none")
 
 
 #Correlationtable
 CorTableInc<-Table[, .(Correlation=round(cor(FourStar, IncomeSubmission),2)), by = category]
 c<-Table[, .(Correlation=round(cor(FourStar, IncomeSubmission),2),category="Total")]
 CorTableInc<-as.data.table(rbind(CorTable,c)) #good
 
 ###ANOVA TESTS
anova(lm(FourStar ~ Name, Table))
anova(lm(FourStar ~ category, Table))

lm(FourStar ~ category, Table)

 
####### INCOME
 
