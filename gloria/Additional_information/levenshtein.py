# -*- coding: utf-8 -*-
"""
The functions defined in this code attemp to calculate the Levenshtein distance 
based similarity between every possible pair of strings from two string lists. 
The output is the averaged Levenshtein similarity. The value ranges between 0 
and 1, with 1 meaning identical 0 meaning no similarity.
"""
import Levenshtein

def levdiff(strlist1, strlist2):
#    dist = 0.
    ratio = 0.
    for i in range(len(strlist1)):
        for j in range(len(strlist2)):
#            dist += Levenshtein.distance(strlist1[i], strlist2[j])
            ratio += Levenshtein.ratio(strlist1[i], strlist2[j])

#    avgdist = dist/(len(strlist1)*len(strlist2))
    avgratio = ratio/(len(strlist1)*len(strlist2))
    return avgratio
