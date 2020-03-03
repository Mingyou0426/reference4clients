import os.path

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import math
from sklearn import ensemble, metrics
%matplotlib inline

sns.set_style('darkgrid')
pd.options.display.float_format = '{:,.2f}'.format

try:
    BASE_DIR = os.path.dirname(os.path.abspath(__file__))
except NameError:
    import sys
    BASE_DIR = os.path.dirname(os.path.abspath(sys.argv[0]))

# BASE_DIR = os.path.dirname(os.path.abspath(''))
BASE_DIR = 'C:\\Users\\User\\Desktop\\wineanalyzer_src\\';
# BASE_DIR = 'E:\\ming\\seongsikj\\wineanalyzer'

wine_csv = pd.read_csv(os.path.join(BASE_DIR, "wine.csv"), encoding = "latin")
# print(wine_csv.head(wine_csv.shape[0]+1))
# # print('\n')
# wine_csv.hist(bins=10, figsize=(20,20))
# plt.show()
print('Total record count: ', wine_csv.shape[0])

# print('\nAverage score per state\n')
state_csv = wine_csv.groupby('state')['score'].mean()
# print(wine_csv.groupby('state')['score'].mean())
print(state_csv)
plt.figure()
state_csv.plot.bar(x='state',y='score',rot=0,figsize=(20,10))

# print('\nAverage score per variety\n')
variety_csv = wine_csv.groupby('variety')['score'].mean()
# print(wine_csv.groupby('variety')['score'].mean())
# pd.set_option('display.max_rows', variety_csv.shape[0]+1)
print(variety_csv)
plt.figure()
variety_csv.plot.bar(x='variety',y='score',rot=0,figsize=(20,10))

# total_scores = []
# for ind in range(0, wine_csv.shape[0]):
#     totscore = 0
#     totscore = wine_csv.loc[ind]['score']*4
#     if wine_csv.loc[ind]['price'] is not None:
#         if wine_csv.loc[ind]['price'] > 300:
#             totscore = totscore + 1 * 3
#         elif wine_csv.loc[ind]['price'] > 230:
#             totscore = totscore + 2 * 3
#         elif wine_csv.loc[ind]['price'] > 100:
#             totscore = totscore + 3 * 3
#         elif wine_csv.loc[ind]['price'] > 50:
#             totscore = totscore + 4 * 3
#         else:
#             totscore = totscore + 5 * 3
#     if wine_csv.loc[ind]['state'] is not None:
#         totscore = totscore + state_csv.loc[wine_csv.loc[ind]['state']]*1.5
#     if wine_csv.loc[ind]['variety'] is not None:
#         if pd.isnull(wine_csv.loc[ind]['variety'])==False:
#             totscore = totscore + variety_csv.loc[wine_csv.loc[ind]['variety']]*1.5
#     total_scores.append(totscore)

# wine_csv['totalscore'] = total_scores
# print(wine_csv)