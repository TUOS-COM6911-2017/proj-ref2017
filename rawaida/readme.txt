How to read my data files structure:-
- Latest scripts are organized per UOAs (Unit of Assessments) in REF 2014
- 10 UOAs (not including Politics) are treated as sample and analysis were conducted on data related to FTE (Full-Time Equivalent)
- In each UOA's folder, two R Notebooks are uploaded (1 for Data Wrangling, 1 for Data Analysis), raw CSV data used for each UOAs
- The rest of unscattered files are documents with respect to business analysis prior to start of the works, and initial plots obtained during the initial analysis
- Contribution towards final report is in the "Report" folder - (coordination & restructuring of the report was done by me)

NOTE - https://github.com/rstudio/rmarkdown/issues/1020 (due to current issues with Git, it didn't properly render R Notebook outputs (files that has .nb.html format is the one that have results) 

NOTE - Eligible FTE data that are used with all UOAs is located in "UOA_ComScience" folder

=======================
Rawaida's Notes & Recording My Progress for this project
=======================

Project Allocated on 9/10/2017
First Presentation on 24/10/2017

From 9/10/2017 to 6/11/2017
Majority time spent on preparing for first presentation which are defining the scopes, timeline and approach how to proceed with the project, understanding REF and RAE background, discussing how to scrape the data from REF 2014 website, and later discover bulk data is available for download. 

=============================================================================
6/11/2017
- Selected two UOAs - UOA 21 (Politics & International Studies) and UOA 11 (Computer Science). Thus, proceed with initial checking of UIA 21 (Politics & International Studies) data. Below are my brief notes on the data after checking and perform initial statistics. (Initial scripts uploaded to Github)
- Total of 20 categories of output submitted by this institutions for this UOA. Top three submission are journal articles (3082), authored book (775), and chapter in book (415).
- Total of 56 universities participated in REF 2014
- Most of papers published date are toward closing date of REF submission date
- Majority of submitted papers are authored by ONE individual
- Found major data quality issues with the submission to proceed with detailed analysis - 99% data is N/A for isInterdisciplinary, 83% data is N/A for Research Group, 100% citedbycount is N/A, and 94% additional info is N/A (Note: total rows in dataset is 4365)

DECISION - Not to proceed with this UOA and select another UOAs

==============================================================================

12/11/2017
Checking data on Computer Science UOA 11

- Total of 16 categories of output submitted by institutions for UOA 11. Top three submissions are journal article (5556), conference contribution (1898) and chapter in book (112). 
- Total of 89 universities participated in REF 2014
- IDEA 1 - to uncover potential correlation by populating data in map format against 4* universities
- Found out top 10 submission of outputs are Edinburgh (401), Oxford (263), UCL (261), Middlesex (212), Imperial (201), Southampton (187), Cambridge (184), Manchester (179), KCL (159) and Bristol (159). (Notes - Sheffield is at ranking 25 with 109 outputs
- IDEA 2 - wish to find out whether there's correlation between number of output submitted to overall stars ranking obtained by institution?
- Pursue the above IDEA by using below data and plot scatterplot between count of output submissted to overall ranking
a) count number of output submission (how many entries in the raw data by each university) - need to merge submission list by universities and the university list
b) stars ranking per universities  - at first decide to do a range of stars for each university - decide NOT to proceed with regards to time

=================================================================================

14/11/2017
Continue to work on IDEA 2 - scatterplot of number of outputs vs % ranking of 4 stars, 3 stars

- Plot each count number of outputs per university versus 4* and 3* per university (use overall instead of outputs ranking alone)
- Plots for both uploaded to this folder - to be discussed with Eleni & Thomas
- Found out can use QGIS to populate raw data into map format - IDEA 1 from 12/11/2017

17 - 19/11/2017
- Install QGIS and figure out how to use this software. Lose time on installation (took 3 days!)
- Spent time to learn how to download base map data for United Kingdom, and how to load them into QGIS. 

==================================================================================

21/11/2017
Relook back at IDEA 2 - deeper understanding of output submissions count vs four stars ranking

- Comment by Eleni - need to map four star of outputs ONLY not Overall and to add third dimension of data e.g. percentage of submission by university to the existing plot

Relook back at IDEA 1 - mapping of data to map format
- ISSUE - spent 1 whole day to load the data multiple times - too many data points since this covers the whole UK and cause my computer to crash many time
- DECISION - decide to abandon this IDEA with respect of time - can be attempted again (MAYBE) if time permits by loading smaller portion of data (perhaps by UK county)

=======================================================================================

25/11/2017
Searching for data to add as third dimension in response to Eleni's comment on 21/11/2017

- Comment by Thomas - number of outputs submitted may not be normalized - may need to find data that represent number of submissions per person
- Looking back to raw data - data available in raw data set - a) number of submission per university b) number of staff per university

Notes for after discussion with Thomas & Eleni on 29/11/2017
- Eleni mentioned normalization of data e.g. number of submission per university divided by number of staff per university would just confirmed REF rules (which is 4 outputs per staff) - NOT WORTH to proceed - SUGGEST to proceed finding other data could substantiate % of submitted data per university against overall staff (as mentioned in 21/11/2017)

=====================================================================================

5/12/2017
- Spent hours to search for data related to FTE data requested by Eleni - did not find it.
- While reading reports in REF 2014 website (in effort for searching the above), stumbled into list of topics categorization done by Panel B team members (for UOA 11 only), with score ranking for each topic, and the count of papers that were categorized in this topic. Good for future research work.
- Towards the end of day, found staff number of university from HESA website (2013 /2014 term). Contemplating to use FTE or this total staff number data per university for selective submission of outputs feature.

=====================================================================================

6/12/2017
- Discussed findings of data with Eleni - staff data not suitable to be used as it will only confirm known rules, which are number of outputs to be submitted per each staff if we were to plot data of total category A FTE vs total head count found in HESA website.
- Relook at HESA website again, and stumbled upon eligible FTE data submitted to REF 2014 by HESA. Good as a source!
- Start work on adding third plot to existing two variables "Total No of Output Submission" and "Four Stars Ranking". Also perform 3D plot on "Eligible FTE", "Submitted FTE", Four Stars Ranking". Sent to Eleni & Thomas for 3D plot. Was advised to look at multiple correlation coefficient.
- Also, tried plotting these variables against "Three Stars", and "Average of Three & Four Stars".
- Re-think whether these plottings make sense for the feature investigated.

=====================================================================================

7/12/2017 - 9/12/2017
- Completed coding on R Notebook for UOA 11, and attempted to work on replicating the same steps to all other 9 sampled UOAs.
- During data pre-processing, 14 universities were not on the submitted list by REF, but available in HESA. Only use the list that matched with REF, with the assumption either these 14 universities do not submit their outputs, or were not included in the REF evaluation. Remembered reading about random audit in REF Panel report about this, which resulted in universities not being included in REF evaluation. Need to re-check!
- Attempted to remove outlier in effort to increase correlation coefficient
- Reading on Multiple Regression / Multivariate Regression to better understand the plots outcome
- Stumbled upon preliminary test to check for test assumptions prior to check for linear correlations - can use Shapiro Wilk normality test to test for normal distribution, and Q-Q plots for visual checking. Decide to add this test code (shapiro.test() ) to test the correct correlation is being used. 
- Managed to complete only 5 UOAs, A2, A5, B9, B11 and C18 only. Have problem working on the rest of UOAs (B12, C24, C25, D32, D36) due to some of the submissions was counted as two, resulting in two different scores ranking for university. Unable to plot because HESA FTE data has only unique values of university. Discovered this upon checking the data in detail. Initially, decided to remove, but then, decide to average the two submission values.
- Up to midnight of 8/12, only manage to average the scores, but not the submitted FTE data. Decide to stop and focus on report, as this is far more important.
- Work on structuring the final report in LATEX according to final report draft structure made earlier by George. Spent time to re-wrote "Introduction" & "Background" section earlier written both by Gloria and Eleanor in Latex. Include references from REF, HESA, HEFCE, etc. Also re-wrote "Lit Review" earlier contributed by George and Gloria (Weijiang) for more coherence.

======================================================================================

10/12/2017
- Working on how best to structure the final report from "Methodology" section up to "Results" for everyone to include their individual part in Latex. Commented in Latex on which portion that the team should upload into.
- Writing and re-writing to put together all the previous results into my section which is "Feature 7 - Selective Submission of Output".
- During discussion with Gloria on the challenges of pre-processing (encountered on 7/12 - 8/12), IDEA came up to just duplicate the FTE values for universities that has multiple submission. Maybe easier compared to merge the other data (merging is complicated, because each UOAs have different university that submit multiple submission, so need to check for another column first, prior to merging).
- Upon in-depth analysis of outputs obtained while writing the report, discovered CRITICAL error of the original plot. Values in the plot does not tally with values in the tables merged during pre-processing. Run and re-run of the code, and checking multiple times to see if the data were pre-processed correctly. It was correct, but the plot still was wrong.
- DECIDE to re-check the data with Python script (Jupyter) and found out plot distributions was different, and correlation was 0.7! (Earlier correlation check done in average for completed UOAs was in between 0.02 - 0.1.
- Upon discussion with George (working with him to complete the final touch of the report, while waiting for Gloria to final check her work), decide to report this unsual occurrences in final report, and NO CONCLUSION can be decided at this point of time for selective submission of outputs.
- Submitted the final report! (and the rest of codes, later)
