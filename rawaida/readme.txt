Rawaida's Notes & Recording My Progress for this project

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

============================================================================================================

14/11/2017
Continue to work on IDEA 2 - scatterplot of number of outputs vs % ranking of 4 stars, 3 stars

- Plot each count number of outputs per university versus 4* and 3* per university (use overall instead of outputs ranking alone)
- Plots for both uploaded to this folder - to be discussed with Eleni & Thomas
- Found out can use QGIS to populate raw data into map format - IDEA 1 from 12/11/2017

17 - 19/11/2017
- Install QGIS and figure out how to use this software. Lose time on installation (took 3 days!)
- Spent time to learn how to download base map data for United Kingdom, and how to load them into QGIS. 

==========================================================================================================

21/11/2017
Relook back at IDEA 2 - deeper understanding of output submissions count vs four stars ranking

- Comment by Eleni - need to map four star of outputs ONLY not Overall and to add third dimension of data e.g. percentage of submission by university to the existing plot

Relook back at IDEA 1 - mapping of data to map format
- ISSUE - spent 1 whole day to load the data multiple times - too many data points since this covers the whole UK and cause my computer to crash many time
- DECISION - decide to abandon this IDEA with respect of time - can be attempted again (MAYBE) if time permits by loading smaller portion of data (perhaps by UK county)

=========================================================================================================

25/11/2017
Searching for data to add as third dimension in response to Eleni's comment on 21/11/2017

- Comment by Thomas - number of outputs submitted may not be normalized - may need to find data that represent number of submissions per person
- Looking back to raw data - data available in raw data set - a) number of submission per university b) number of staff per university

Notes for after discussion with Thomas & Eleni on 29/11/2017
- Eleni mentioned normalization of data e.g. number of submission per university divided by number of staff per university would just confirmed REF rules (which is 4 outputs per staff) - NOT WORTH to proceed - SUGGEST to proceed finding other data could substantiate % of submitted data per university against overall staff (as mentioned in 21/11/2017)

=======================================================================================================

5/12/2017


