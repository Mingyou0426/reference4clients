import os.path

import plotly.graph_objs as go
import pandas as pd

# import matplotlib.pyplot as plt
import math

# float value precision
pd.options.display.float_format = '{:,.2f}'.format
# base path for product list csv file
BASE_DIR = 'E:\\ming\\seongsikj\\wineanalyzer'

# open csv
wine_csv = pd.read_csv(os.path.join(BASE_DIR, "wine.csv"), encoding = "latin")
fig = go.Figure(data=[go.Table(
    header=dict(values=list(wine_csv.columns),
                fill_color='paleturquoise',
                align='left'),
    cells=dict(values=[wine_csv.id, wine_csv.country, wine_csv.title, wine_csv.score, wine_csv.price, wine_csv.state, wine_csv.region_1, wine_csv.region_2, wine_csv.variety, wine_csv.winery],
               fill_color='lavender',
               align='left'))
])
fig.show()
# print total record count of wine product
print('Total number of the wine product: ', wine_csv.shape[0])
print('\n')
print('1. State attribute analysis')
# average of score for state
state_csv = wine_csv.groupby('state')['score'].mean()
state_csv4view = state_csv.sort_values(ascending=False).head(10)
dic = state_csv4view.to_dict()
state = list(dic.keys())
score = list(dic.values())

for i in range(len(score)):
    val = round(score[i],2)
    score[i] = val    

state1 = {'state': state, 'score': score}
df = pd.DataFrame(state1)
# print(df)
fig = go.Figure(data=[go.Table(
    header=dict(values=df.columns,
                fill_color='paleturquoise',
                align='left'),
    cells=dict(values=[df.state, df.score],
               fill_color='lavender',
               align='left'))
])
fig.show()

fig1 = go.Figure(data=[go.Bar(
            x=state, y=score,
            text=score,
            textposition='auto',
        )])
fig1.show()

# print(state_csv4view)
# print('\n\n')
# preprocess for state chart
# plt.figure()
# # state chart
# ax = state_csv4view.plot.bar(x='state',y='score',rot=0,figsize=(20,10))
# for p in ax.patches:
#     ax.annotate(str('%.2f'%(p.get_height())), (p.get_x() * 1.005, p.get_height() * 1.005))

# print('\n\n')
# print('2. Variety attribute analysis\n')
# # average of score for variety
# variety_csv = wine_csv.groupby('variety')['score'].mean()
# pd.set_option('display.max_rows', variety_csv.shape[0]+1)
# print(variety_csv)
# print('\n\n')
# # preprocess for state chart
# plt.figure()
# # variety chart
# variety_csv.plot.bar(x='variety',y='score',rot=0,figsize=(20,10))

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