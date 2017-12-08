library(plyr)
mean2= ddply(Overall, .(Region), summarize, Fourmean=mean(FourStar), Threemean=mean(ThreeStar), Twomean=mean(TwoStar), Onemean=mean(OneStar), Unclassmean= mean(Unclassified))
# This just makes a dataset of the mean % pf each grade by region, original code from: https://stackoverflow.com/questions/21982987/mean-per-group-in-a-data-frame

Meanformat <- t(mean2[-1])
colnames(Meanformat) <- mean2[, 1]
# This formats it for use in the barchart below. Original code from: original code from https://stackoverflow.com/questions/14544124/grouped-bar-graph-using-barplot

par(xpd=TRUE) # This lets me put the legend outside the chart area
op <- par(mar=c(8,4,3,2))
barplot(Meanformat,col=c("dodgerblue1","lightseagreen","darkolivegreen3","orangered2","chocolate4"),xlab="",ylab="%",las=2,cex.names=0.65)
mtext("Stacked Barchart Showing the Distribution of Grades Across Regions",side=3,line=2)
legend(1,110,legend=c("4* Grade", "3* Grade","2* Grade","1* Grade", "Unclassified Grade"," "),text.width=c(1.7,1.7,1.7,1.7,1.7,1.7),col=c("dodgerblue1","lightseagreen","darkolivegreen3","orangered2","chocolate4","white"),pch=15,horiz=TRUE, cex=0.7)
mtext("Region", side=1, line=6.5) 