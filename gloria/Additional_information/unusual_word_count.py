# -*- coding: utf-8 -*-
"""
This file includes functions that takes the additional information dictionary
built using extract_addinfor.py to perform a series of tasks - tokenization,
calculating tfidf and calculating unusual word counts.
"""

import re
import math
import numpy as np

# use a dictionary containing paragraphs to build a dictionary of words
def worddictize(paradict):
    wordRE = re.compile('[a-zA-Z]+') # ignoring potential low frequency words such as weblink or patent number
    worddict = {}
    for rank, paralist in paradict.items():
        worddict[rank] = {}
        parano = 0
        for para in paralist:
            lower = para.lower()
            wordlist = [word for word in wordRE.findall(lower)]
#            wordlist = [WordNetLemmatizer().lemmatize(word) for word in word_tokenize(para)]
            worddict[rank][parano] = wordlist
            parano += 1
    return worddict

# calculate tfidf
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
        for para, wordlist in institutiondict.items():
            tflist = tf(wordlist)
            idflist = []
            for word in wordlist:
                idflist.append(idf(word, institutiondict)) # normalise by institution
            tfidfdict[rank][para] = np.array(tflist) * np.array(idflist)
    return tfidfdict

# calculate unusual word count
def unusualwordcount(tfidfdict):
    # average tfidf at the 95 percentile - define 95 percentile as "unusual"
    avgperclist = []
    for rank, institutiondict in tfidfdict.items():
        percentile = 0.
        parano = 0.
        for para, scorearray in institutiondict.items():
            percentile += np.percentile(scorearray,95)
            parano += 1
        avgperclist.append(percentile/parano)
        avgperc = sum(avgperclist) / float(len(avgperclist))
        
    # count number of words above average threshold
    unusualwordcountdict = {}
    for rank, institutiondict in tfidfdict.items():
        count = 0.
        parano = 0.
        for para, scorearray in institutiondict.items():
            count += sum(scorearray > avgperc)
            parano += 1
        unusualwordcountdict[rank] = count/parano
    
    return avgperclist, avgperc, unusualwordcountdict



