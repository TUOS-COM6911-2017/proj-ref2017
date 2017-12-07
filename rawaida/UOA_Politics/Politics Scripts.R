install.packages("plyr")
# Make sure tick "plyr" in R under "Packages" to ensure count functions could run

# Draw simple statistics on Politics dataset
# merge the data from Politics_Institution with Politics_Output
P_DataSet <- merge(Politics_Institution, Politics_Ouput)
summary(P_DataSet)

# 1) Draw barplot of Output Data Type of DataSetMerged

P_OutputTypeFreq <- count(P_DataSet, c("OutputType"))
# change into matrix format so that barplot can be performed
P_OutputTypeFreq <- as.matrix(OutputTypeFreq)
barplot(P_OutputFreq, names.arg = OutputType, xlab = "OutputType", ylab = "Freq")

# 2) Draw plot of Year of DataSetMerged
P_Year <- as.matrix(count(P_DataSet, c("Year")))
plot(P_Year, ylab = "Frequency")

# 3) Draw histogram of No of Additional Authors
hist(P_DataSet$NumberOfAdditionalAuthors, xlim = c(0, 4), xlab = "No of Additional Authors", ylab = "Frequency")

# 4) Count number of output that is interdisciplinary
interdisciplinary <- as.matrix(count(P_DataSet, c("IsInterdisciplinary")))

# 5) Count population of research group
P_researchGrp <- count(P_DataSet, c("ResearchGroup"))
barplot(P_researchGrp[, c('freq')], names.arg = P_researchGrp[, c('ResearchGroup')], xlab = "Research Group", ylab = "Frequency")

# 6) Count population of cited by count (data error - missing)
P_citeCount <- count(P_DataSet, c("CitedByCount"))
P_citeFalse <- count(P_DataSet, c("CitationsApplicable"))

# 7) Count population of Additional Info
P_addInfo <- count(P_DataSet, c("AdditionalInformation"))

# 8) No of Universities (56 universities participated)
P_UnivCount <- count(P_DataSet, c("Name")) 
barplot(P_UnivCount[, c('freq')], names.arg = P_UnivCount[, c('Name')]) # not useful

# 1 simple correlation - not done yet
P_MergedSubmission <- merge(Politics_Submission_Profile, Politics_Institution)

