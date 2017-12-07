# -*- coding: utf-8 -*-
"""
This code attempts to give a rank to the universities in a UOA based on all 
of the overall scores for 4*, 3*, 2*, 1* and UC. A dataframe containing the ranked
submission profile can be obtained.
"""
import os
import pandas as pd
import numpy as np

# set directory and load csv
os.chdir('path\\to\\data')
#os.chdir('/media/glorwlin/0C98231C982303B4/REF/Data/12 - Aeronautical, Mechanical, Chemical and Manufacturing Engineering_normalised')

submissionProfile = pd.read_csv('submissionProfile.csv', sep=',')
#submissionProfile.set_index('UKPRN', inplace=True)
outputDetails = pd.read_csv('output.csv', sep=',')
#outputDetails.set_index('Identifier', inplace=True)

# rank results 4* --> 3* --> 2* --> 1* --> Unclassified
index_overall = submissionProfile.index[submissionProfile['Profile']=='Overall'].tolist()
overall = submissionProfile.loc[index_overall]
overall.sort_values(['FourStar', 'ThreeStar', 'TwoStar', 'OneStar', 'Unclassified'], ascending=[False, False, False, False, True], inplace=True)

# A dataframe containing output scores can also be obtained based on overall rank
index_output_sortedbyoverall = np.array(overall.index.tolist()) - 1 
output = submissionProfile.loc[index_output_sortedbyoverall]

