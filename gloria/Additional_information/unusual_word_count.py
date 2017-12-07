# -*- coding: utf-8 -*-
"""
This file includes functions that takes the additional information dictionary
built using extract_addinfor.py to perform a series of tasks - tokenization,
calculating tfidf, calculating unusual word counts and computing correlations
with overall 4* and output 4* scores.
"""
import time
import re
import math
import numpy as np
import pickle
from scipy.stats.stats import pearsonr 

###############################################################################
# calculate tfidf and count unusual words
def worddictize(paradict):
    wordRE = re.compile('[a-zA-Z]+') # ignoring potential low frequency words such as weblink or patent number
    worddict = {}
    for rank, paralist in paradict.items():
        worddict[rank] = {}
        parano = 0
        for parano, para in paralist.items():
            lower = para.lower()
            wordlist = [word for word in wordRE.findall(lower)]
#            wordlist = [WordNetLemmatizer().lemmatize(word) for word in word_tokenize(para)]
            worddict[rank][parano] = wordlist
            parano += 1
    
    with open('worddict.pkl', 'wb') as handle:
        pickle.dump(worddict, handle, protocol=pickle.HIGHEST_PROTOCOL)

    return worddict

def tf(wordlist):
    tflist = []
    for word in wordlist:
        tflist.append(wordlist.count(word))
    return tflist

def n_containing(word, institutiondict):
    n = 0.
    for para, wordlist in institutiondict.items():
        if word in wordlist:
            n += 1
    return n

def idf(word, institutiondict): 
    return math.log(len(institutiondict) / (n_containing(word, institutiondict)))

def tfidf(worddict):
    tfidfdict = {}
    for rank, institutiondict in worddict.items():
        tfidfdict[rank] = {}
        if len(institutiondict) != 0:
            for para, wordlist in institutiondict.items():
                tflist = tf(wordlist)
                idflist = []
                for word in wordlist:
                    idflist.append(idf(word, institutiondict)) # normalise by institution
                tfidfdict[rank][para] = np.array(tflist) * np.array(idflist)
    with open('byins_tfidfdict.pkl', 'wb') as handle:
        pickle.dump(tfidfdict, handle, protocol=pickle.HIGHEST_PROTOCOL)
    return tfidfdict

def unusualwordcount(tfidfdict):
    # define a range of tfidf thresholds above which words are considered "unusual"
    avgperc = []
    for i in range(20):
        avgperclist = []
        for rank, institutiondict in tfidfdict.items():
            if len(institutiondict) != 0:
                percentile = 0.
                parano = 0.
                for para, scorearray in institutiondict.items():
                    percentile += np.percentile(scorearray, (100-0.5*(i+1)))
                    parano += 1
                avgperclist.append(percentile/parano)
        avgperc.append(sum(avgperclist) / float(len(avgperclist)))
        
    # count number of words above average threshold
    unusualwordcountdict = {}
    for i in range(20):
        unusualwordcountdict[100-0.5*(i+1)] = {}
        for rank, institutiondict in tfidfdict.items():
            if len(institutiondict) != 0:
                count = 0.
                parano = 0.
                for para, scorearray in institutiondict.items():
                    count += sum(scorearray > avgperc[i])
                    parano += 1
                unusualwordcountdict[100-0.5*(i+1)][rank] = count/parano
            else:
                unusualwordcountdict[100-0.5*(i+1)][rank] = 0
                
    with open('byins_unusualwordcountdict.pkl', 'wb') as handle:
        pickle.dump(unusualwordcountdict, handle, protocol=pickle.HIGHEST_PROTOCOL)

    return avgperclist, avgperc, unusualwordcountdict

# calculate Pearson correlation coefficients
## The Pearson correlation coefficient measures the linear relationship between two datasets. 
## This varies between -1 and +1 with 0 implying no correlation.
## The p-value roughly indicates the probability of an uncorrelated system producing datasets 
## that have a Pearson correlation at least as extreme as the one computed from these datasets. 
## The p-values are not entirely reliable but are probably reasonable for datasets larger than 500 or so.
def correlation(unusualwordcountdict):
    x_overall = overall['FourStar'].tolist()
    x_output = output['FourStar'].tolist()
    correlations = np.zeros((20,3))
    correlations[:,0] = sorted(unusualwordcountdict.keys())
    for i in range(20):
        lists = sorted(unusualwordcountdict[correlations[i,0]].items()) # sorted by key, return a list of tuples
        _, y = zip(*lists) # unpack a list of pairs into two tuples
        correlations[i,1] = pearsonr(x_overall,y)[0]
        correlations[i,2] = pearsonr(x_output,y)[0]
    maxc = np.argmax(abs(correlations[:,[1,2]]), axis=0)
    print('The percentile that gives best correlation for overall 4* score is %.1f.' % correlations[maxc[0],0])
    print('The persentile that gives best correlation for output 4* score is %.1f.' % correlations[maxc[1],0])
    if abs(correlations[maxc[0],1]) > abs(correlations[maxc[1],2]):
        print('Better correlation with overall 4* score.')
    elif abs(correlations[maxc[0],1]) == abs(correlations[maxc[1],2]):
        print('Same correlation with overall and output.')
    else:
        print('Better correlation with output 4* score.')
    np.savetxt('correlations.csv', correlations, fmt=['% .1f','% .3f','% .3f'], delimiter=',', newline='\n')
    return correlations



#####
worddict = worddictize(addinfor)

#####
start = time.time() 
tfidfdict = tfidf(worddict)
print('It took {0:0.1f} seconds'.format(time.time() - start)) # ~ 130s

#####
start = time.time() 
avgperclist, avgperc, unusualwordcountdict = unusualwordcount(tfidfdict)
print('It took {0:0.1f} seconds'.format(time.time() - start))

#####
correlations = correlation(unusualwordcountdict)





###############################################################################
# calculate tfidf by normalising across all documents
## This method is not recommended.
def tf(worddict):
    tf = {}
    for rank, institutiondict in worddict.items():
        tf[rank] = {}
        for para, wordlist in institutiondict.items():
            tf[rank][para] = {}
            for word in wordlist:
                tf[rank][para][word] = wordlist.count(word)
    with open('alldoc_tfdict.pkl', 'wb') as handle:
        pickle.dump(tf, handle, protocol=pickle.HIGHEST_PROTOCOL)
    return tf

def tfmerge(tfdict):
    tfmerged = {}
    for rank, insdict in tfdict.items():
        if len(insdict) == 0:
            tfmerged[rank] = {}
        elif len(insdict) == 1:
            tfmerged[rank] = tfdict[rank][0]
        elif len(insdict) == 2:
            tfmerged[rank] = {x: 0 for x in set(insdict[0]).union(insdict[1])}
        else:
            merged = {x: 0 for x in set(insdict[0]).union(insdict[1])}
            for i in range(len(insdict)-2):
                merged = {x: 0 for x in set(merged).union(insdict[i+2])}
            tfmerged[rank] = merged   
    
    merged = {x: 0 for x in set(tfmerged[0]).union(tfmerged[1])}
    for i in range(len(tfmerged)-2):
        if len(tfmerged[i+2]) != 0:
            merged = {x: 0 for x in set(merged).union(tfmerged[i+2])}  
    with open('alldoc_tfmerged.pkl', 'wb') as handle:
        pickle.dump(merged, handle, protocol=pickle.HIGHEST_PROTOCOL)
    return merged

def n_containing(word, worddict):
    n = 0.
    for rank, institutiondict in worddict.items():
        for para, wordlist in institutiondict.items():
            if word in wordlist:
                n += 1
    return n

def idf(worddict, tfmerged):
    totalDoc = sum(addinforsummary[:,2])
    for word in tfmerged:
        tfmerged[word] = math.log(totalDoc / (n_containing(word, worddict)))
    with open('alldoc_idfdict.pkl', 'wb') as handle:
        pickle.dump(tfmerged, handle, protocol=pickle.HIGHEST_PROTOCOL)
    return tfmerged
    
def tfidf(tfdict, idfdict):
    tfidfdict = {}
    for rank, insdict in tfdict.items():
        tfidfdict[rank] = {}
        for para, words in insdict.items():
            tfidfdict[rank][para] = {}
            for word, count in words.items():
                tfidfdict[rank][para][word] = words[word] * idfdict[word]
    with open('alldoc_tfidfdict.pkl', 'wb') as handle:
        pickle.dump(tfidfdict, handle, protocol=pickle.HIGHEST_PROTOCOL)
    return tfidfdict

def unusualwordcount(tfidfdict):
    # average tfidf at the 95 percentile - define tfidf below 95 percentile as "unusual"
    avgperclist = []
    for rank, institutiondict in tfidfdict.items():
        if len(institutiondict) != 0:
            percentile = 0.
            parano = 0.
            for para, scores in institutiondict.items():
                scorearray = np.array(list(scores.values()))
                scorearray = scorearray[~np.isnan(scorearray)]
                percentile += np.percentile(scorearray,95)
                parano += 1
            avgperclist.append(percentile/parano)
            avgperc = sum(avgperclist) / float(len(avgperclist))
        
    # count number of words above average threshold
    unusualwordcountdict = {}
    for rank, institutiondict in tfidfdict.items():
        if len(institutiondict) != 0:
            count = 0.
            parano = 0.
            for para, scores in institutiondict.items():
                scorearray = np.array(list(scores.values()))
                count += sum(scorearray > avgperc)
                parano += 1
            unusualwordcountdict[rank] = count/parano
        else:
            unusualwordcountdict[rank] = 0
    with open('alldoc_unusualworddict.pkl', 'wb') as handle:
        pickle.dump(tfidfdict, handle, protocol=pickle.HIGHEST_PROTOCOL)
    return avgperclist, avgperc, unusualwordcountdict





