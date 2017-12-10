# NOT THE LATEST ONE

install.packages("plyr")
# Make sure tick "plyr" in R under "Packages" to ensure count functions could run

# Draw simple statistics on Computer Science dataset
# merge the data from Politics_Institution with Politics_Output
CS_DataSet <- merge(ComScience_Institution, ComScience_Output)
CS_StarDataSet <- merge(ComScience_Institution, ComScience_SubmissionProfile)
summary(CS_DataSet)

#1) Population of output data submitted
CS_OutputType <- as.matrix(count(CS_DataSet, c("OutputType")))
#plot(CS_OutputType[, c('freq')], CS_OutputType[, c('OutputType')]) / not working

#2) Population of participated universities & total submitted outputs
CS_UnivCount <- as.matrix(count(CS_DataSet, c("Name")))

#3) Population of 4, 3, 2, 1, U/C Stars University

# filter datasets for overall 4 /3 / 2 stars / UC only with overall stars ranking only
# note - Name : FourStar - means selecting column from Name to FourStar
CS_fourstar <- subset.data.frame(CS_StarDataSet, subset = CS_StarDataSet$Profile == 'Overall', select = Name : FourStar)
CS_threestar <- subset.data.frame(CS_StarDataSet, subset = CS_StarDataSet$Profile == 'Overall', select = Name : ThreeStar)
CS_twostar <- subset.data.frame(CS_StarDataSet, subset = CS_StarDataSet$Profile == 'Overall', select = Name : TwoStar)
CS_onestar <- subset.data.frame(CS_StarDataSet, subset = CS_StarDataSet$Profile == 'Overall', select = Name : OneStar)
CS_unclass <- subset.data.frame(CS_StarDataSet, subset = CS_StarDataSet$Profile == 'Overall', select = Name : Unclassified)

#Ideas - to see whether there's correlation between numbers of outputs submitted vs stars ranking
plot(CS_UnivCount[,2], CS_unclass$FourStar, xlab = "No of Outputs Submitted", ylab = "% Submission Meeting Four Stars")
plot(CS_unclass$FourStar,CS_UnivCount[,2] , xlab = "% Submission Meeting Four Stars", ylab = "No of Outputs Submitted")













# 1) Draw barplot of Output Data Type of DataSetMerged

CS_OutputTypeFreq <- count(CS_DataSet, c("OutputType"))
# change into matrix format so that barplot can be performed
CS_OutputTypeFreq <- as.matrix(CS_OutputTypeFreq)

barplot.default(CS_OutputTypeFreq[, c('freq')], names.arg = CS_OutputTypeFreq[, c('OutputType')], xlab = "OutputType", ylab = "Freq")

# 2) Draw plot of Year of DataSetMerged
CS_Year <- as.matrix(count(CS_DataSet, c("Year")))
plot(CS_Year, ylab = "Frequency")

# 3) Draw histogram of No of Additional Authors
hist(CS_DataSet$NumberOfAdditionalAuthors, xlab = "No of Additional Authors", ylab = "Frequency")

# 4) Count number of output that is interdisciplinary
CS_interdisciplinary <- as.matrix(count(CS_DataSet, c("IsInterdisciplinary")))

# 5) Count population of research group
CS_researchGrp <- count(CS_DataSet, c("ResearchGroup"))
barplot(CS_researchGrp[c('freq')], names.arg = CS_researchGrp[, c('ResearchGroup')], xlab = "Research Group", ylab = "Frequency")

# 6) Count population of cited by count (data error - missing)
CS_citeCount <- count(CS_DataSet, c("CitedByCount"))
CS_citeFalse <- count(CS_DataSet, c("CitationsApplicable"))

# 7) Count population of Additional Info
CS_addInfo <- count(CS_DataSet, c("AdditionalInformation"))

# 8) No of Universities (56 universities participated)
CS_UnivCount <- count(CS_DataSet, c("Name")) 
barplot(CS_UnivCount[, c('freq')], names.arg = CS_UnivCount[, c('Name')]) # not useful

# 1 simple correlation - not done yet
CS_MergedSubmission <- merge(ComScience_Submission_Profile,ComScience_Institution)

