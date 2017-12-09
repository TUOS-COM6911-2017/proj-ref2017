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

UnusualPubliHealth<-as.data.table(read_excel(path="GloriaUnusualWords.xlsx", sheet="UOA2"))
UnusualBiolScience<-as.data.table(read_excel(path="GloriaUnusualWords.xlsx", sheet="UOA5"))
UnusualPhysics<-as.data.table(read_excel(path="GloriaUnusualWords.xlsx", sheet="UOA9"))
UnusualComputerScience<-as.data.table(read_excel(path="GloriaUnusualWords.xlsx", sheet="UOA11"))
UnusualAeroMechanic<-as.data.table(read_excel(path="GloriaUnusualWords.xlsx", sheet="UOA12"))
UnusualEconomics<-as.data.table(read_excel(path="GloriaUnusualWords.xlsx", sheet="UOA18"))
UnusualAntropology<-as.data.table(read_excel(path="GloriaUnusualWords.xlsx", sheet="UOA24"))
UnusualEducation<-as.data.table(read_excel(path="GloriaUnusualWords.xlsx", sheet="UOA25"))
UnusualPhilosophy<-as.data.table(read_excel(path="GloriaUnusualWords.xlsx", sheet="UOA32"))
UnusualCommunication<-as.data.table(read_excel(path="GloriaUnusualWords.xlsx", sheet="UOA36"))

str(UnusualPubliHealth)

############# OVERALL #############

p1 <- ggplot(UnusualPubliHealth, aes(x=FourStarOverall, y=UnusalWordsOverall, color=NameOfUniversity))
p1<-p1 + geom_point() + #avoid plotting outliers twice
  theme(axis.text.x = element_text(angle = 90, 
                                   hjust = 1),legend.position = "none")+
  ggtitle("Public Health") +
  ylim(0,50) + xlab("% of 4* Outcome") +
  ylab("Number of unusual words") +
  scale_y_continuous(limits=c(0, 25))+
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10))

p2 <- ggplot(UnusualBiolScience, aes(x=FourStarOverall, y=UnusalWordsOverall, color=NameOfUniversity))
p2<-p2 + geom_point() + #avoid plotting outliers twice
  theme(axis.text.x = element_text(angle = 90, 
                                   hjust = 1),legend.position = "none")+
  ggtitle("Bological Science") +
  ylim(0,50) + xlab("% of 4* Outcome") +
  ylab("Number of unusual words") +
  scale_y_continuous(limits=c(0, 25))+#scale without one outlier
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10))


#Here nice correlation
p3 <- ggplot(UnusualPhysics, aes(x=FourStarOverall, y=UnusalWordsOverall, color=NameOfUniversity))
p3<-p3 + geom_point() + #avoid plotting outliers twice
  theme(axis.text.x = element_text(angle = 90, 
                                   hjust = 1),legend.position = "none")+
  ggtitle("Physics") +
  ylim(0,50) + xlab("") +
  ylab("") +
  scale_y_continuous(limits=c(0, 25))+#scale without one outlier
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10))

#Nice correlation
p4 <- ggplot(UnusualComputerScience, aes(x=FourStarOverall, y=UnusalWordsOverall, color=NameOfUniversity))
p4<-p4 + geom_point() + #avoid plotting outliers twice
  theme(axis.text.x = element_text(angle = 90, 
                                   hjust = 1),legend.position = "none")+
  ggtitle("Computer Science") +
  ylim(0,50)+ xlab("") +
  ylab("") +
  scale_y_continuous(limits=c(0, 10))+#scale without one outlier
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10))

p5 <- ggplot(UnusualAeroMechanic, aes(x=FourStarOverall, y=UnusalWordsOverall, color=NameOfUniversity))
p5<-p5 + geom_point() + #avoid plotting outliers twice
  theme(axis.text.x = element_text(angle = 90, 
                                   hjust = 1),legend.position = "none")+
  ggtitle("Aeronautical, Mechanical, Chemical*") +
  ylim(0,50) + xlab("") +
  ylab("") +
  scale_y_continuous(limits=c(0, 10))+#scale without one outlier
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10))

p6 <- ggplot(UnusualEconomics, aes(x=FourStarOverall, y=UnusalWordsOverall, color=NameOfUniversity))
p6<-p6 + geom_point() + #avoid plotting outliers twice
  theme(axis.text.x = element_text(angle = 90, 
                                   hjust = 1),legend.position = "none")+
  ggtitle("Economics and Econometrics") +
  ylim(0,50) + xlab("") +
  ylab("") +
  scale_y_continuous(limits=c(0, 25))+#scale without one outlier
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10))

p7 <- ggplot(UnusualAntropology, aes(x=FourStarOverall, y=UnusalWordsOverall, color=NameOfUniversity))
p7<-p7 + geom_point() + #avoid plotting outliers twice
  theme(axis.text.x = element_text(angle = 90, 
                                   hjust = 1),legend.position = "none")+
  ggtitle("Anthropology and Development Studies") +
  ylim(0,50) + xlab("") +
  ylab("") +
  scale_y_continuous(limits=c(0, 75))+#scale without one outlier
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10))

p8 <- ggplot(UnusualEducation, aes(x=FourStarOverall, y=UnusalWordsOverall, color=NameOfUniversity))
p8<-p8 + geom_point() + #avoid plotting outliers twice
  theme(axis.text.x = element_text(angle = 90, 
                                   hjust = 1),legend.position = "none")+
  ggtitle("Education") + xlab("") +
  ylab("") +
  ylim(0,50) +
  scale_y_continuous(limits=c(0, 120))+#scale without one outlier
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10))

p9 <- ggplot(UnusualPhilosophy, aes(x=FourStarOverall, y=UnusalWordsOverall, color=NameOfUniversity))
p9<-p9 + geom_point() + #avoid plotting outliers twice
  theme(axis.text.x = element_text(angle = 90, 
                                   hjust = 1),legend.position = "none")+
  ggtitle("Philosophy") +
  ylim(0,50) + xlab("") +
  ylab("") +
  scale_y_continuous(limits=c(0, 40))+#scale without one outlier
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10))

p10 <- ggplot(UnusualCommunication, aes(x=FourStarOverall, y=UnusalWordsOverall, color=NameOfUniversity))
p10<-p10 + geom_point() + #avoid plotting outliers twice
  theme(axis.text.x = element_text(angle = 90, 
                                   hjust = 1),legend.position = "none")+
  ggtitle("Communication, Cultural, Media**") +
  ylim(0,50) + xlab("") +
  ylab("") +
  scale_y_continuous(limits=c(0, 45))+#scale without one outlier
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10))

# Multiplot function
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
multiplot(p1,p2,p3,p4,p5,p6,p7,p8,p9,p10, cols=5)

rm(p1,p2,p3,p4,p5,p6,p7,p8,p9,p10)
#PEARSOM TEST, SPEARMAN, SM

cor(UnusualPubliHealth$FourStarOverall, UnusualPubliHealth$UnusalWordsOverall)
cor(UnusualBiolScience$FourStarOverall, UnusualBiolScience$UnusalWordsOverall)
cor(UnusualPhysics$FourStarOverall, UnusualPhysics$UnusalWordsOverall)#0.52
cor(UnusualComputerScience$FourStarOverall, UnusualComputerScience$UnusalWordsOverall)# Cor 0.45
cor(UnusualAeroMechanic$FourStarOverall, UnusualAeroMechanic$UnusalWordsOverall)#Cor.0,.62
cor(UnusualEconomics$FourStarOverall, UnusualEconomics$UnusalWordsOverall)
cor(UnusualAntropology$FourStarOverall, UnusualAntropology$UnusalWordsOverall)#0.41
cor(UnusualEducation$FourStarOverall, UnusualEducation$UnusalWordsOverall)
cor(UnusualPhilosophy$FourStarOverall, UnusualPhilosophy$UnusalWordsOverall)
cor(UnusualCommunication$FourStarOverall, UnusualCommunication$UnusalWordsOverall)

############## OUTPUT #################

g1 <- ggplot(UnusualPubliHealth, aes(x=FourStarOutput, y=UnusualWordsOutput, color=NameOfUniversity))
g1<-g1 + geom_point() + #avoid plotting outliers twice
  theme(axis.text.x = element_text(angle = 90, 
                                   hjust = 1),legend.position = "none")+
  ggtitle("Public Health") +
  ylim(0,50) + xlab("% of 4* Outcome") +
  ylab("Number of unusual words") +
  scale_y_continuous(limits=c(0, 25))+
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10))

g2 <- ggplot(UnusualBiolScience, aes(x=FourStarOutput, y=UnusualWordsOutput, color=NameOfUniversity))
g2<-g2 + geom_point() + #avoid plotting outliers twice
  theme(axis.text.x = element_text(angle = 90, 
                                   hjust = 1),legend.position = "none")+
  ggtitle("Bological Science") +
  ylim(0,50) + xlab("% of 4* Outcome") +
  ylab("Number of unusual words") +
  scale_y_continuous(limits=c(0, 25))+#scale without one outlier
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10))


#Here nice correlation
g3 <- ggplot(UnusualPhysics, aes(x=FourStarOutput, y=UnusualWordsOutput, color=NameOfUniversity))
g3<-g3 + geom_point() + #avoid plotting outliers twice
  theme(axis.text.x = element_text(angle = 90, 
                                   hjust = 1),legend.position = "none")+
  ggtitle("Physics") +
  ylim(0,50) + xlab("") +
  ylab("") +
  scale_y_continuous(limits=c(0, 25))+#scale without one outlier
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10))

#Nice correlation
g4 <- ggplot(UnusualComputerScience, aes(x=FourStarOutput, y=UnusualWordsOutput, color=NameOfUniversity))
g4<-g4 + geom_point() + #avoid plotting outliers twice
  theme(axis.text.x = element_text(angle = 90, 
                                   hjust = 1),legend.position = "none")+
  ggtitle("Computer Science") +
  ylim(0,50) + xlab("") +
  ylab("") +
  scale_y_continuous(limits=c(0, 10))+#scale without one outlier
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10))

g5 <- ggplot(UnusualAeroMechanic, aes(x=FourStarOutput, y=UnusualWordsOutput, color=NameOfUniversity))
g5<-g5 + geom_point() + #avoid plotting outliers twice
  theme(axis.text.x = element_text(angle = 90, 
                                   hjust = 1),legend.position = "none")+
  ggtitle("Aeronautical, Mechanical, Chemical**") +
  ylim(0,50) + xlab("") +
  ylab("") +
  scale_y_continuous(limits=c(0, 10))+#scale without one outlier
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10))

g6 <- ggplot(UnusualEconomics, aes(x=FourStarOutput, y=UnusualWordsOutput, color=NameOfUniversity))
g6<-g6 + geom_point() + #avoid plotting outliers twice
  theme(axis.text.x = element_text(angle = 90, 
                                   hjust = 1),legend.position = "none")+
  ggtitle("Economics and Econometrics") +
  ylim(0,50) + xlab("") +
  ylab("") +
  scale_y_continuous(limits=c(0, 25))+#scale without one outlier
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10))

g7 <- ggplot(UnusualAntropology, aes(x=FourStarOutput, y=UnusualWordsOutput, color=NameOfUniversity))
g7<-g7 + geom_point() + #avoid plotting outliers twice
  theme(axis.text.x = element_text(angle = 90, 
                                   hjust = 1),legend.position = "none")+
  ggtitle("Anthropology and Development Studies") +
  ylim(0,50) + xlab("") +
  ylab("") +
  scale_y_continuous(limits=c(0, 35))+#scale without one outlier
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10))

g8 <- ggplot(UnusualEducation, aes(x=FourStarOutput, y=UnusualWordsOutput, color=NameOfUniversity))
g8<-g8 + geom_point() + #avoid plotting outliers twice
  theme(axis.text.x = element_text(angle = 90, 
                                   hjust = 1),legend.position = "none")+
  ggtitle("Education") +
  ylim(0,50) + xlab("") +
  ylab("") +
  scale_y_continuous(limits=c(0, 100))+#scale without one outlier
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10))

g9 <- ggplot(UnusualPhilosophy, aes(x=FourStarOutput, y=UnusualWordsOutput, color=NameOfUniversity))
g9<-g9 + geom_point() + #avoid plotting outliers twice
  theme(axis.text.x = element_text(angle = 90, 
                                   hjust = 1),legend.position = "none")+
  ggtitle("Philosophy") +
  ylim(0,50) + xlab("") +
  ylab("") +
  scale_y_continuous(limits=c(0, 30))+#scale without one outlier
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10))

g10 <- ggplot(UnusualCommunication, aes(x=FourStarOutput, y=UnusualWordsOutput, color=NameOfUniversity))
g10<-g10 + geom_point() + #avoid plotting outliers twice
  theme(axis.text.x = element_text(angle = 90, 
                                   hjust = 1),legend.position = "none")+
  ggtitle("Communication, Cultural and Media*") +
  ylim(0,50) + xlab("") +
  ylab("") +
  scale_y_continuous(limits=c(0, 45))+#scale without one outlier
  theme(plot.title = element_text(hjust =0.5, vjust=2.12, size=10))

multiplot(g1,g2,g3,g4,g5,g6,g7,g8,g9,g10, cols=5)

rm(g1,g2,g3,g4,g5,g6,g7,g8,g9,g10)
#PEARSOM TEST, SPEARMAN, SM

cor(UnusualPubliHealth$FourStarOutput, UnusualPubliHealth$UnusualWordsOutput)
cor(UnusualBiolScience$FourStarOutput, UnusualBiolScience$UnusualWordsOutput)
cor(UnusualPhysics$FourStarOutput, UnusualPhysics$UnusualWordsOutput)#0.51
cor(UnusualComputerScience$FourStarOutput, UnusualComputerScience$UnusualWordsOutput)# Cor 0.41
cor(UnusualAeroMechanic$FourStarOutput, UnusualAeroMechanic$UnusualWordsOutput)#Cor.0.55
cor(UnusualEconomics$FourStarOutput, UnusualEconomics$UnusualWordsOutput)
cor(UnusualAntropology$FourStarOutput, UnusualAntropology$UnusualWordsOutput)#0.34
cor(UnusualEducation$FourStarOutput, UnusualEducation$UnusualWordsOutput)
cor(UnusualPhilosophy$FourStarOutput, UnusualPhilosophy$UnusualWordsOutput)
cor(UnusualCommunication$FourStarOutput, UnusualCommunication$UnusualWordsOutput)

#Analysis between groups
d1<-as.data.table(cbind(UnusualPubliHealth$FourStarOutput, UnusualPubliHealth$UnusualWordsOutput,"PublicHealth"))
d2<-as.data.table(cbind(UnusualBiolScience$FourStarOutput, UnusualBiolScience$UnusualWordsOutput,"BiolScience"))
d3<-as.data.table(cbind(UnusualPhysics$FourStarOutput, UnusualPhysics$UnusualWordsOutput,"Physics"))
d4<-as.data.table(cbind(UnusualComputerScience$FourStarOutput, UnusualComputerScience$UnusualWordsOutput,"ComputerScience"))
d5<-as.data.table(cbind(UnusualAeroMechanic$FourStarOutput, UnusualAeroMechanic$UnusualWordsOutput,"AeroMechanic"))
d6<-as.data.table(cbind(UnusualEconomics$FourStarOutput, UnusualEconomics$UnusualWordsOutput,"Economics"))
d7<-as.data.table(cbind(UnusualAntropology$FourStarOutput, UnusualAntropology$UnusualWordsOutput,"Antropology"))
d8<-as.data.table(cbind(UnusualEducation$FourStarOutput, UnusualEducation$UnusualWordsOutput,"Education"))
d9<-as.data.table(cbind(UnusualPhilosophy$FourStarOutput, UnusualPhilosophy$UnusualWordsOutput,"Philosophy"))
d10<-as.data.table(cbind(UnusualCommunication$FourStarOutput, UnusualCommunication$UnusualWordsOutput,"UnusualCommunication"))

TableOutput<-as.data.table(rbind(d1,d2,d3,d4,d5,d6,d7,d8,d9,d10))
colnames(TableOutput)<-c("Four","UnWords","Category")

TableOutput$Four<-as.numeric(TableOutput$Four)
TableOutput$UnWords<-as.numeric(TableOutput$UnWords)
TableOutput$Category<-as.factor(TableOutput$Category)

##Test 
testOutput<-cor(TableOutput$Four, TableOutput$UnWords)

######

d1<-as.data.table(cbind(UnusualPubliHealth$FourStarOverall, UnusualPubliHealth$UnusalWordsOverall,"PublicHealth"))
d2<-as.data.table(cbind(UnusualBiolScience$FourStarOverall, UnusualBiolScience$UnusalWordsOverall,"BiolScience"))
d3<-as.data.table(cbind(UnusualPhysics$FourStarOverall, UnusualPhysics$UnusalWordsOverall,"Physics"))
d4<-as.data.table(cbind(UnusualComputerScience$FourStarOverall, UnusualComputerScience$UnusalWordsOverall,"ComputerScience"))
d5<-as.data.table(cbind(UnusualAeroMechanic$FourStarOverall, UnusualAeroMechanic$UnusalWordsOverall,"AeroMechanic"))
d6<-as.data.table(cbind(UnusualEconomics$FourStarOverall, UnusualEconomics$UnusalWordsOverall,"Economics"))
d7<-as.data.table(cbind(UnusualAntropology$FourStarOverall, UnusualAntropology$UnusalWordsOverall,"Antropology"))
d8<-as.data.table(cbind(UnusualEducation$FourStarOverall, UnusualEducation$UnusalWordsOverall,"Education"))
d9<-as.data.table(cbind(UnusualPhilosophy$FourStarOverall, UnusualPhilosophy$UnusalWordsOverall,"Philosophy"))
d10<-as.data.table(cbind(UnusualCommunication$FourStarOverall, UnusualCommunication$UnusalWordsOverall,"UnusualCommunication"))

TableOverall<-as.data.table(rbind(d1,d2,d3,d4,d5,d6,d7,d8,d9,d10))
colnames(TableOverall)<-c("Four","UnWords","Category")

TableOverall$Four<-as.numeric(TableOverall$Four)
TableOverall$UnWords<-as.numeric(TableOverall$UnWords)
TableOverall$Category<-as.factor(TableOverall$Category)

rm(d1,d2,d3,d4,d5,d6,d7,d8,d9,d10)

#Test
testOverall<-cor(TableOverall$Four, TableOverall$UnWords)

###No correlation for all UOA's


#SM TEST??
install.packages("Skillings.Mack")
library(Skillings.Mack)
library("reshape")

#Data cast before - neeeeds improvements!!
Ski.Mack(TableOverall$Four, groups="Category")
Ski.Mack(TableOutput$Four, groups="Category")
