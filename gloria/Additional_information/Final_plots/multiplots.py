# -*- coding: utf-8 -*-
"""

"""
import os
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from scipy.stats.stats import pearsonr 

os.chdir('F:\\2017-2018 Sheffield Data Analytics\\Industrial_team_project\\Data')

uoa2 = pd.read_excel('GloriaUnusualWords.xlsx', sheet_name = 'UOA2', header = None)
uoa5 = pd.read_excel('GloriaUnusualWords.xlsx', sheet_name = 'UOA5', header = None)
uoa9 = pd.read_excel('GloriaUnusualWords.xlsx', sheet_name = 'UOA9', header = None)
uoa11 = pd.read_excel('GloriaUnusualWords.xlsx', sheet_name = 'UOA11', header = None)
uoa12 = pd.read_excel('GloriaUnusualWords.xlsx', sheet_name = 'UOA12', header = None)
uoa18 = pd.read_excel('GloriaUnusualWords.xlsx', sheet_name = 'UOA18', header = None)
uoa24 = pd.read_excel('GloriaUnusualWords.xlsx', sheet_name = 'UOA24', header = None)
uoa25 = pd.read_excel('GloriaUnusualWords.xlsx', sheet_name = 'UOA25', header = None)
uoa32 = pd.read_excel('GloriaUnusualWords.xlsx', sheet_name = 'UOA32', header = None)
uoa36 = pd.read_excel('GloriaUnusualWords.xlsx', sheet_name = 'UOA36', header = None)

x11 = uoa2[2].tolist()
y11 = uoa2[1].tolist()
x12 = uoa2[4].tolist()
y12 = uoa2[3].tolist()

x21 = uoa5[2].tolist()
y21 = uoa5[1].tolist()
x22 = uoa5[4].tolist()
y22 = uoa5[3].tolist()

x31 = uoa9[2].tolist()
y31 = uoa9[1].tolist()
x32 = uoa9[4].tolist()
y32 = uoa9[3].tolist()

x41 = uoa11[2].tolist()
y41 = uoa11[1].tolist()
x42 = uoa11[4].tolist()
y42 = uoa11[3].tolist()

x51 = uoa12[2].tolist()
y51 = uoa12[1].tolist()
x52 = uoa12[4].tolist()
y52 = uoa12[3].tolist()

x61 = uoa18[2].tolist()
y61 = uoa18[1].tolist()
x62 = uoa18[4].tolist()
y62 = uoa18[3].tolist()

x71 = uoa24[2].tolist()
y71 = uoa24[1].tolist()
x72 = uoa24[4].tolist()
y72 = uoa24[3].tolist()

x81 = uoa25[2].tolist()
y81 = uoa25[1].tolist()
x82 = uoa25[4].tolist()
y82 = uoa25[3].tolist()

x91 = uoa32[2].tolist()
y91 = uoa32[1].tolist()
x92 = uoa32[4].tolist()
y92 = uoa32[3].tolist()

x101 = uoa36[2].tolist()
y101 = uoa36[1].tolist()
x102 = uoa36[4].tolist()
y102 = uoa36[3].tolist()



font = {'color':  'black',
        'weight': 'normal',
        'size': 16,
        }

f, axarr = plt.subplots(2, 5, figsize=(18,9))
axarr[0, 0].scatter(x11, y11)
axarr[0, 0].set_title('UOA2-Health')
axarr[0, 0].annotate(r'corr. = %.2f' % pearsonr(x11, y11)[0], xy=(0.5, 0.95), xycoords='axes fraction', fontsize = 'large')
axarr[0, 1].scatter(x21, y21)
axarr[0, 1].set_title('UOA5-Bio Science')
axarr[0, 1].annotate(r'corr. = %.2f' % pearsonr(x21, y21)[0], xy=(0.5, 0.95), xycoords='axes fraction', fontsize = 'large')
axarr[0, 2].scatter(x31, y31)
axarr[0, 2].set_title('UOA9-Physics')
axarr[0, 2].annotate(r'corr. = %.2f' % pearsonr(x31, y31)[0], xy=(0.5, 0.95), xycoords='axes fraction', fontsize = 'large')
axarr[0, 3].scatter(x41, y41)
axarr[0, 3].set_title('UOA11-Computer Science')
axarr[0, 3].annotate(r'corr. = %.2f' % pearsonr(x41, y41)[0], xy=(0.05, 0.95), xycoords='axes fraction', fontsize = 'large')
axarr[0, 4].scatter(x51, y51)
axarr[0, 4].set_title('UOA12-Engineering')
axarr[0, 4].annotate(r'corr. = %.2f' % pearsonr(x51, y51)[0], xy=(0.5, 0.05), xycoords='axes fraction', fontsize = 'large')
axarr[1, 0].scatter(x61, y61)
axarr[1, 0].set_title('UOA18-Economics')
axarr[1, 0].annotate(r'corr. = %.2f' % pearsonr(x61, y61)[0], xy=(0.5, 0.95), xycoords='axes fraction', fontsize = 'large')
axarr[1, 1].scatter(x71, y71)
axarr[1, 1].set_title('UOA24-Anthropology')
axarr[1, 1].annotate(r'corr. = %.2f' % pearsonr(x71, y71)[0], xy=(0.5, 0.95), xycoords='axes fraction', fontsize = 'large')
axarr[1, 2].scatter(x81, y81)
axarr[1, 2].set_title('UOA25-Education')
axarr[1, 2].annotate(r'corr. = %.2f' % pearsonr(x81, y81)[0], xy=(0.5, 0.95), xycoords='axes fraction', fontsize = 'large')
axarr[1, 3].scatter(x91, y91)
axarr[1, 3].set_title('UOA32-Philosophy')
axarr[1, 3].annotate(r'corr. = %.2f' % pearsonr(x91, y91)[0], xy=(0.5, 0.05), xycoords='axes fraction', fontsize = 'large')
axarr[1, 4].scatter(x101, y101)
axarr[1, 4].set_title('UOA36-Communication')
axarr[1, 4].annotate(r'corr. = %.2f' % pearsonr(x101, y101)[0], xy=(0.5, 0.95), xycoords='axes fraction', fontsize = 'large')
f.text(0.5, 0.05, 'Average unusual word cound per submission', ha='center', fontdict=font)
f.text(0.08, 0.5, 'Overall 4* scores', va='center', rotation='vertical', fontdict=font)
f.savefig('overall4star_UWC.png')
plt.close(f)

f, axarr = plt.subplots(2, 5, figsize=(18,9))
axarr[0, 0].scatter(x12, y12)
axarr[0, 0].set_title('UOA2-Health')
axarr[0, 0].annotate(r'corr. = %.2f' % pearsonr(x12, y12)[0], xy=(0.5, 0.95), xycoords='axes fraction', fontsize = 'large')
axarr[0, 1].scatter(x22, y22)
axarr[0, 1].set_title('UOA5-Bio Science')
axarr[0, 1].annotate(r'corr. = %.2f' % pearsonr(x22, y22)[0], xy=(0.5, 0.95), xycoords='axes fraction', fontsize = 'large')
axarr[0, 2].scatter(x32, y32)
axarr[0, 2].set_title('UOA9-Physics')
axarr[0, 2].annotate(r'corr. = %.2f' % pearsonr(x32, y32)[0], xy=(0.5, 0.95), xycoords='axes fraction', fontsize = 'large')
axarr[0, 3].scatter(x42, y42)
axarr[0, 3].set_title('UOA11-Computer Science')
axarr[0, 3].annotate(r'corr. = %.2f' % pearsonr(x42, y42)[0], xy=(0.55, 0.95), xycoords='axes fraction', fontsize = 'large')
axarr[0, 4].scatter(x52, y52)
axarr[0, 4].set_title('UOA12-Engineering')
axarr[0, 4].annotate(r'corr. = %.2f' % pearsonr(x52, y52)[0], xy=(0.5, 0.05), xycoords='axes fraction', fontsize = 'large')
axarr[1, 0].scatter(x62, y62)
axarr[1, 0].set_title('UOA18-Economics')
axarr[1, 0].annotate(r'corr. = %.2f' % pearsonr(x62, y62)[0], xy=(0.5, 0.95), xycoords='axes fraction', fontsize = 'large')
axarr[1, 1].scatter(x72, y72)
axarr[1, 1].set_title('UOA24-Anthropology')
axarr[1, 1].annotate(r'corr. = %.2f' % pearsonr(x72, y72)[0], xy=(0.5, 0.95), xycoords='axes fraction', fontsize = 'large')
axarr[1, 2].scatter(x82, y82)
axarr[1, 2].set_title('UOA25-Education')
axarr[1, 2].annotate(r'corr. = %.2f' % pearsonr(x82, y82)[0], xy=(0.5, 0.95), xycoords='axes fraction', fontsize = 'large')
axarr[1, 3].scatter(x92, y92)
axarr[1, 3].set_title('UOA32-Philosophy')
axarr[1, 3].annotate(r'corr. = %.2f' % pearsonr(x92, y92)[0], xy=(0.5, 0.05), xycoords='axes fraction', fontsize = 'large')
axarr[1, 4].scatter(x102, y102)
axarr[1, 4].set_title('UOA36-Communication')
axarr[1, 4].annotate(r'corr. = %.2f' % pearsonr(x102, y102)[0], xy=(0.5, 0.95), xycoords='axes fraction', fontsize = 'large')
f.text(0.5, 0.05, 'Average unusual word cound per submission', ha='center', fontdict=font)
f.text(0.08, 0.5, 'Output 4* scores', va='center', rotation='vertical', fontdict=font)
f.savefig('output4star_UWC.png')
plt.close(f)
