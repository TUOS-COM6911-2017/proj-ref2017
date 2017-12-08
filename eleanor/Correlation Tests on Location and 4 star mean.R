# I made the list of distances from london seperate from the mean_overalls dataset then merged the two
#hence
Mean_Overalls=cbind(Mean_Overalls,Distances)
plot(Mean_Overalls$`Distance from London`,Mean_Overalls$FourStarMean) 
# Seeing if there is a correlation. Doesn't look like one.
plot(lm(Mean_Overalls$`Distance from London`~Mean_Overalls$FourStarMean)) 
# Checking normality. The data is decidedly not normal.
plot(lm(log(Mean_Overalls$`Distance from London`)~Mean_Overalls$FourStarMean)) 
# Log transforming the distance to attempt to normalise the data, 
# it doesn't work so I run a spearman's rank test with the untransformed data
cor.test(Mean_Overalls$`Distance from London`,Mean_Overalls$FourStarMean,method=c("spearman"))
#Spearman's rank correlation rho

#data:  Mean_Overalls$`Distance from London` and Mean_Overalls$FourStarMean
#S = 735790, p-value = 0.00935
#alternative hypothesis: true rho is not equal to 0
#sample estimates:
#  rho 
#-0.2088194 

#Despite a P value of less than 0.05