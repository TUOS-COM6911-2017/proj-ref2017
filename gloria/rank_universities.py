# -*- coding: utf-8 -*-
"""
This code attempts to give a rank to the universities in a UOA based on all 
of the overall scores for 4*, 3*, 2*, 1* and UC. The output is a dataframe 
containing the rank information.
"""
import os
import pandas as pd

# set directory and load csv
os.chdir('H:\\REF\\Data\\12 - Aeronautical, Mechanical, Chemical and Manufacturing Engineering_normalised')
#os.chdir('/media/glorwlin/0C98231C982303B4/REF/Data/12 - Aeronautical, Mechanical, Chemical and Manufacturing Engineering_normalised')

submissionProfile = pd.read_csv('submissionProfile.csv', sep=',')
#submissionProfile.set_index('UKPRN', inplace=True)
outputDetails = pd.read_csv('output.csv', sep=',')
#outputDetails.set_index('Identifier', inplace=True)

# rank results 4* --> 3* --> 2* --> 1* --> Unclassified
index_overall = submissionProfile.index[submissionProfile['Profile']=='Overall'].tolist()
overall = submissionProfile.loc[index_overall]
overall.sort_values(['FourStar', 'ThreeStar', 'TwoStar', 'OneStar', 'Unclassified'], ascending=[False, False, False, False, True], inplace=True)

