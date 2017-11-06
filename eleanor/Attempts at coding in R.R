OnlyOverall=subset(OnlyOverall, Profile!="Outputs")
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