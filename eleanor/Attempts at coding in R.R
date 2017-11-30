# To make a dataset containing only the overall scores
OnlyOverall=subset(Initial_Test, Profile=="Outputs") # Initial_Test is the file from REF2014
OnlyOverall=subset(OnlyOverall, Profile!="Impact")
OnlyOverall=subset(OnlyOverall, Profile!="Environment")

par(mfrow=c(3,2))
boxplot(OnlyOverall$FourStar~OnlyOverall$Institution,main="Boxplot of Four Star Results by University")
boxplot(OnlyOverall$ThreeStar~OnlyOverall$Institution,main="Boxplot of Three Star Results by University")
boxplot(OnlyOverall$TwoStar~OnlyOverall$Institution, main="Boxplot of Two Star Results by University")
boxplot(OnlyOverall$OneStar~OnlyOverall$Institution,main="Boxplot of One Star Results by University")
boxplot(OnlyOverall$Unclassified~OnlyOverall$Institution,main="Boxplot of Unclassified Results by University")


library(plyr)
ddply(OnlyOverall, .(SortOrder), summarize,  FourStarMean=mean(FourStar), ThreeStarMean=mean(ThreeStar), TwoStarMean=mean(TwoStar), OneStarMean=mean(OneStar), UnclassifiedMean=mean(Unclassified))

Original code from: https://stackoverflow.com/questions/21982987/mean-per-group-in-a-data-frame



# For plotting the mean scores of each university on one graph.
# Letstryit is the Mean_Overalls dataset.
plot(factor(letstryit$Institution),letstryit$FourStarMean,ylab="% Mark",xlab="University", ylim=c(0,80),main="Plot showing the mean scores for each university")
points(factor(letstryit$Institution),letstryit$ThreeStarMean, pch= 15,col="red", cex=0.35)
points(factor(letstryit$Institution),letstryit$TwoStarMean, pch= 15,col="darkgreen", cex=0.35)
points(factor(letstryit$Institution),letstryit$OneStarMean, pch= 15,col="blue", cex=0.35)
points(factor(letstryit$Institution),letstryit$UnclassifiedMean, pch= 15,col="deeppink", cex=0.35)
legend("topright", legend=c("Four Star Mean","Three Star Mean", "Two Star Mean","One Star mean","Unclassifed Mean"), col=c("black","red", "darkgreen","blue","deeppink"), pch=15, cex=0.5, horiz=TRUE)



# original code from https://stackoverflow.com/questions/14544124/grouped-bar-graph-using-barplot
mymat <- t(Meanbyregion[-1])

colnames(mymat) <- Meanbyregion[, 1]
barplot(mymat,col=c("plum1","plum","plum2","plum3","plum4"),xlab="Region",ylab="%")
legend(0.5,120,legend=c("4* Grade", "3* Grade","2* Grade","1* Grade", "Unclassified Grade"," "),text.width=c(1.7,1.7,1.7,1.7,1.7,1.7),col=c("plum1","plum","plum2","plum3","plum4","white"),pch=15,horiz=TRUE, cex=0.7)

op <- par(mar=c(7.8,4,1.55,2))
barplot(mymat,col=c("plum1","plum","plum2","plum3","plum4"),xlab="",ylab="%",las=2,cex.names=0.65)
legend(0.5,118,legend=c("4* Grade", "3* Grade","2* Grade","1* Grade", "Unclassified Grade"," "),text.width=c(1.7,1.7,1.7,1.7,1.7,1.7),col=c("plum1","plum","plum2","plum3","plum4","white"),pch=15,horiz=TRUE, cex=0.7)
mtext("Region", side=1, line=6.5)


barplot(mymat,col=c("plum1","plum","plum2","plum3","plum4"),xlab="",ylab="%",las=2,cex.names=0.7)
mtext("Region", side=1, line=6.5)