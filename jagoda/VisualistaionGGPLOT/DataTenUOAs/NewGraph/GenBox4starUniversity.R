setwd("/Users/gosc/Desktop/TEAM_PROJECT/")
getwd()


library(readxl)
library(data.table)
library(ggplot2)
library(plyr)
library(dplyr)
library(reshape)
library(magrittr)

######## Importing data ##########


RankBiolScience<-as.data.table(read_excel(path="GeorgerankingAUS.xlsx", sheet="Biology"))
RankPubhealth<-as.data.table(read_excel(path="GeorgerankingAUS.xlsx", sheet="Publichealth"))
RankPhysics<-as.data.table(read_excel(path="GeorgerankingAUS.xlsx", sheet="Physics"))
RankComputerScience<-as.data.table(read_excel(path="GeorgerankingAUS.xlsx", sheet="ComputerScience"))
RankAeroMechanic<-as.data.table(read_excel(path="GeorgerankingAUS.xlsx", sheet="Aeronautical"))
RankEconomics<-as.data.table(read_excel(path="GeorgerankingAUS.xlsx", sheet="Economics"))
RankAntropology<-as.data.table(read_excel(path="GeorgerankingAUS.xlsx", sheet="Antropology"))
RankEducation<-as.data.table(read_excel(path="GeorgerankingAUS.xlsx", sheet="Education"))
RankPhilosophy<-as.data.table(read_excel(path="GeorgerankingAUS.xlsx", sheet="Philosophy"))
RankCommunication<-as.data.table(read_excel(path="GeorgerankingAUS.xlsx", sheet="Communication"))
Dict<-as.data.table(read_excel(path="GeorgerankingAUS.xlsx", sheet="DICT"))


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
plot + geom_point(size=0.5, alpha=0.5) + 
  geom_smooth(formula = y ~ x, se=FALSE)+
 # geom_smooth(alpha=0.5)+
  theme(axis.text.x = element_text(angle = 90, 
                                   hjust = 1),legend.position = "bottom")+
  ggtitle("Average journal ranking vs. 4* Output") +
  ylim(0,80) + xlab("") +
  ylab("") +
  scale_y_continuous(limits=c(0, 80))+#scale without one outlier
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10))

plot2 <- ggplot(Table, aes(y=FourStar, x=AvgRank))
plot2 + geom_point(size=0.5, alpha=0.5) + 
  geom_smooth(formula = y ~ x)+
  # geom_smooth(alpha=0.5)+
  theme(axis.text.x = element_text(angle = 90, 
                                   hjust = 1),legend.position = "bottom")+
  ggtitle("Average journal ranking vs. 4* Output") +
  ylim(0,80) + xlab("") +
  ylab("") +
  scale_y_continuous(limits=c(0, 80))+#scale without one outlier
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10))

plot3 <- ggplot(Table, aes(y=FourStar, x=category, color=category))
pl3<-plot3 + geom_boxplot()+geom_jitter()+ggtitle("Category vs. 4*") +
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=12),
                                  axis.text.x = element_text(angle = 90, hjust = 1),
        legend.position = "none")

  
plot4 <- ggplot(Table, aes(y=AvgRank, x=category, color=category))
pl4<-plot4 + geom_boxplot()+geom_jitter()+ggtitle("Category vs. AvgRank*") +
    theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=12),
                                    axis.text.x =element_text(angle = 90, hjust = 1),
          legend.position="none")
  
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
 anova(lm(StressReduction ~ University * Category, dataTwoWayComparisons))

