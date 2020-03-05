import os.path

import pandas as pd
import matplotlib.pyplot as plt
import math

# float value precision
pd.options.display.float_format = '{:,.2f}'.format
# base path for product list csv file
BASE_DIR = 'C:\\Users\\User\\Desktop\\wine_project\\';

# open csv
wine_csv = pd.read_csv(os.path.join(BASE_DIR, "wine_project.csv"), encoding = "latin")
# print total record count of wine product
print('Total number of the wine product: ', wine_csv.shape[0])
print('\n\n')
print('1. State attribute analysis\n')
# average of score for state
state_csv = wine_csv.groupby('state')['score'].mean()
print(state_csv)
print('\n\n')
# preprocess for state chart
plt.figure()
# state chart
state_csv.plot.bar(x='state',y='score',rot=0,figsize=(20,10))

print('\n\n')
print('2. Variety attribute analysis\n')
# average of score for variety
variety_csv = wine_csv.groupby('variety')['score'].mean()
print(variety_csv)
print('\n\n')
# preprocess for state chart
plt.figure()
# variety chart
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