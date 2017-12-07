# -*- coding: utf-8 -*-
"""
Given the ranked university dataframe obtained from rank_university.py 
based on all overall scores, the additional information is extracted from 
the outputs.csv and stored in a dictionary corresponding to the overall rank 
(i.e. key = rank). There is also a summary array for the additional information
as part of the outputs. The average percentage of submissions that include 
additional informaiton is also calculated.
"""
import numpy as np
import pickle, re

# overall: a dataframe containing the overall scores for all universities in ranked order
# ouputDetails: a dataframe converted directly from output.csv

def extractai(overall, outputDetails):

    uniranklist = overall['UKPRN'].tolist()
    
    # create an array to summarise additional information
    addinforsummary = np.zeros((len(uniranklist),4)) 
    addinforsummary[:,0] = uniranklist # UKPRN in ranked order
    
    # create a dictionary storing all additional information
    addinfor = {}  
    
    count = 0
    multisub = overall['MultipleSubmission'].notnull().astype(int).tolist()
    for unino in uniranklist:
        if multisub[count] == 0:
    #    if type(overall['MultipleSubmission'].iloc[count]) == float:
        # if there is no multiple submission for a university, extract everthing for the university
            orilist = outputDetails.loc[outputDetails['UKPRN'] == int(unino)]['AdditionalInformation'].tolist()
        else:
        # if there is multiple submissions for a university, extract additional infor separetely
            allsubmission = outputDetails.loc[outputDetails['UKPRN'] == int(unino)]
            orilist = allsubmission.loc[outputDetails['MultipleSubmission'] == overall.iloc[count]['MultipleSubmission']]['AdditionalInformation'].tolist()
    
        addinforsummary[count,1] = len(orilist) # number of submissions
        
        # for addinfor dictionary, key = rank, value = list of additional information
        # only extract the paragraph if the field is not empty
        addinfor[count] = {}
        rmRE = re.compile(r'<[0-9]+>') # eliminate strings like '<23>'
        parano = 0
        for para in orilist:
            if type(para) == str:
                para_nonum = rmRE.sub('', para)
#                if para_nonum != '':
                if len(para_nonum) > 4: # eliminate strings like '.' or 'n/a.'
                    addinfor[count][parano] = para_nonum
                    parano += 1
        
        addinforsummary[count,2] = len(addinfor[count]) # number of submissions with additional information
        addinforsummary[count,3] = addinforsummary[count,2]/addinforsummary[count,1] # fraction of submissions with additional information
        count += 1
        
    # save the summary array
    np.savetxt('addinforsummary.csv', addinforsummary, fmt=['% d','% d','% d','% .3f'], delimiter=',', newline='\n')
    # save addinfor dictionary
    with open('addinfordict.pkl', 'wb') as handle:
        pickle.dump(addinfor, handle, protocol=pickle.HIGHEST_PROTOCOL)
        
    return addinfor, addinforsummary

#####
# create addinfor dictionary and addinforsummary array
addinfor, addinforsummary = extractai(overall, outputDetails)
    
# check % of additional information available in submissions
mean_perc = np.mean(addinforsummary[:,3]) * 100



