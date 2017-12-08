#4* Grade
wilcox.test(Overall$FourStar~Overall$Group,paired=FALSE)
#W = 137860, p-value < 2.2e-16
mean(Overall$FourStar[Overall$Group=="Russell"])
#[1] 34.24288
mean(Overall$FourStar[Overall$Group=="Non-Russell"])
#[1] 16.66318
#Provides strong evidence that Russell group institutions have a higher average % of 4* results

#3* Grade
wilcox.test(Overall$ThreeStar~Overall$Group,paired=FALSE)
#W = 331630, p-value = 4.412e-13
mean(Overall$ThreeStar[Overall$Group=="Russell"])
#[1] 47.62969
mean(Overall$ThreeStar[Overall$Group=="Non-Russell"])
#[1] 42.23875
#Provides strong evidence that Russell group institutions have a higher average % of 3* results

# 2* Grade
wilcox.test(Overall$TwoStar~Overall$Group,paired=FALSE)
#W = 687050, p-value < 2.2e-16
mean(Overall$TwoStar[Overall$Group=="Russell"])
#16.17391
mean(Overall$TwoStar[Overall$Group=="Non-Russell"])
#31.67685

# 1* Grade
wilcox.test(Overall$OneStar~Overall$Group,paired=FALSE)
#W = 622240, p-value < 2.2e-16
mean(Overall$OneStar[Overall$Group=="Russell"])
#[1] 1.661169
mean(Overall$OneStar[Overall$Group=="Non-Russell"])
#[1] 8.135048

#Unclassified Grade
wilcox.test(Overall$Unclassified~Overall$Group,paired=FALSE)
#W = 481990, p-value = 1.767e-13
mean(Overall$Unclassified[Overall$Group=="Russell"])
#[1] 0.2923538
mean(Overall$Unclassified[Overall$Group=="Non-Russell"])
#[1] 1.286174

par(mfrow=c(2,3))
plot(Overall$FourStar~Overall$Group, ylab=c("% of 4* Results"), xlab=c("Group"))
plot(Overall$ThreeStar~Overall$Group,ylab=c("% of 3* Results"), xlab=c("Group"))
plot(Overall$TwoStar~Overall$Group,ylab=c("% of 2* Results"), xlab=c("Group"))
plot(Overall$OneStar~Overall$Group,ylab=c("% of 1* Results"), xlab=c("Group"))
plot(Overall$Unclassified~Overall$Group,ylab=c("% of Unclassified Results"), xlab=c("Group"))