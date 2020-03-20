import os.path

import plotly.graph_objs as go
import pandas as pd

# import matplotlib.pyplot as plt
import math

# float value precision
pd.options.display.float_format = '{:,.2f}'.format
# base path for product list csv file
# BASE_DIR = 'C:\\Users\\User\\Desktop\\wine_project\\';
BASE_DIR = 'E:\\ming\\seongsikj\\wineanalyzer';

# open csv
print('List of wine products')
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
print('\n')
print('The score of the state which is calculated all of the sum of each states score and then divided by the number of the states products')
print('\nScore of states')
# average of score for state
state_csv = wine_csv.groupby('state')['score'].mean()
dic = state_csv.to_dict()
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

# print('Top 10 of the states')
layout = go.Layout(
    title=go.layout.Title(
        text='Top 10 of the states'
    ),
    xaxis=go.layout.XAxis(
        title=go.layout.xaxis.Title(
            text='States',
            font=dict(
                family='Courier New, monospace',
                size=18,
                color='#7f7f7f'
            )
        )
    ),
    yaxis=go.layout.YAxis(
        title=go.layout.yaxis.Title(
            text='Score',
            font=dict(
                family='Courier New, monospace',
                size=18,
                color='#7f7f7f'
            )
        )
    )
)
state_csv4view = state_csv.sort_values(ascending=False).head(10)
dic = state_csv4view.to_dict()
state = list(dic.keys())
score = list(dic.values())

for i in range(len(score)):
    val = round(score[i],2)
    score[i] = val    

state1 = {'state': state, 'score': score}
df = pd.DataFrame(state1)

fig1 = go.Figure(data=[go.Bar(
            x=state, y=score,
            text=score,
            textposition='auto',
        )], layout=layout)
fig1.show()
print('\n')
print('2. Price attribute analysis(Added)')
print('\n')
print('The score of the price which is calculated all of the sum of each price score and then divided by the number of the price products')
print('\nScore of prices')
# average of score for price
# wine_csv["price"].fillna(0, inplace = True) 
price_csv = wine_csv.groupby('price')['score'].mean()
dic = price_csv.to_dict()
price = list(dic.keys())
score = list(dic.values())

for i in range(len(score)):
    val = round(score[i],2)
    score[i] = val    

price1 = {'price': price, 'score': score}
df = pd.DataFrame(price1)
# print(df)
fig = go.Figure(data=[go.Table(
    header=dict(values=df.columns,
                fill_color='paleturquoise',
                align='left'),
    cells=dict(values=[df.price, df.score],
               fill_color='lavender',
               align='left'))
])
fig.show()

# print('Top 10 of the prices')
layout = go.Layout(
    title=go.layout.Title(
        text='Top 10 of the prices'
    ),
    xaxis=go.layout.XAxis(
        title=go.layout.xaxis.Title(
            text='Prices',
            font=dict(
                family='Courier New, monospace',
                size=18,
                color='#7f7f7f'
            )
        )
    ),
    yaxis=go.layout.YAxis(
        title=go.layout.yaxis.Title(
            text='Score',
            font=dict(
                family='Courier New, monospace',
                size=18,
                color='#7f7f7f'
            )
        )
    )
)
price_csv4view = price_csv.sort_values(ascending=False).head(10)
dic = price_csv4view.to_dict()
price = list(dic.keys())
score = list(dic.values())

for i in range(len(score)):
    val = round(score[i],2)
    score[i] = val    

price1 = {'price': price, 'score': score}
df = pd.DataFrame(price1)

fig1 = go.Figure(data=[go.Bar(
            x=price, y=score,
            text=score,
            textposition='auto',
        )], layout=layout)
fig1.show()

print('\n\n')
print('3. Price attribute analysis\n')
print('Price_score is defined based on the price and "Null" is elminated\n')
print('Price_score criteria')

fig = go.Figure(data=[go.Table(header=dict(values=['The range of Price($)', 'Point'],
                fill_color='paleturquoise',
                align='left'),
                cells=dict(values=[['0-20', '21-40', '41-60', '61-80', '81-100', '101-120', '121-140', '141-180', '181-250', '251~']
                                    , [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]],
                fill_color='lavender',
                align='left'))])
fig.show()

titlelist = []
pricelist = []
pricescore = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
indexlist = []
newind = 0
nullcnt = 0
for ind in range(0, wine_csv.shape[0]):
    if wine_csv.loc[ind]['price'] is not None:
        newind = newind+1
        indexlist.append(newind)
        titlelist.append(wine_csv.loc[ind]['title'])
        pricelist.append(wine_csv.loc[ind]['price'])
        if wine_csv.loc[ind]['price'] > 250:
            pricescore[9] = pricescore[9]+1
        elif wine_csv.loc[ind]['price'] > 180:
            pricescore[8] = pricescore[8]+1
        elif wine_csv.loc[ind]['price'] > 140:
            pricescore[7] = pricescore[7]+1
        elif wine_csv.loc[ind]['price'] > 120:
            pricescore[6] = pricescore[6]+1
        elif wine_csv.loc[ind]['price'] > 100:
            pricescore[5] = pricescore[5]+1
        elif wine_csv.loc[ind]['price'] > 80:
            pricescore[4] = pricescore[4]+1
        elif wine_csv.loc[ind]['price'] > 60:
            pricescore[3] = pricescore[3]+1
        elif wine_csv.loc[ind]['price'] > 40:
            pricescore[2] = pricescore[2]+1
        elif wine_csv.loc[ind]['price'] > 20:
            pricescore[1] = pricescore[1]+1
        elif wine_csv.loc[ind]['price'] > 0:
            pricescore[0] = pricescore[0]+1
        else:
            nullcnt = nullcnt+1

layout = go.Layout(
    title=go.layout.Title(
        text='Point distribution'
    ),
    xaxis=go.layout.XAxis(
        title=go.layout.xaxis.Title(
            text='Wine ID',
            font=dict(
                family='Courier New, monospace',
                size=18,
                color='#7f7f7f'
            )
        )
    ),
    yaxis=go.layout.YAxis(
        title=go.layout.yaxis.Title(
            text='Wine price($)',
            font=dict(
                family='Courier New, monospace',
                size=18,
                color='#7f7f7f'
            )
        )
    )
)

fig = go.Figure(data=go.Scatter(x=indexlist, y=pricelist, mode='markers'), layout=layout)
fig.show()

xvalue = [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
layout = go.Layout(
    title=go.layout.Title(
        text='Point distribution'
    ),
    xaxis=go.layout.XAxis(
        title=go.layout.xaxis.Title(
            text='Point',
            font=dict(
                family='Courier New, monospace',
                size=18,
                color='#7f7f7f'
            )
        )
    ),
    yaxis=go.layout.YAxis(
        title=go.layout.yaxis.Title(
            text='Number of wine',
            font=dict(
                family='Courier New, monospace',
                size=18,
                color='#7f7f7f'
            )
        )
    )
)

fig1 = go.Figure(data=[go.Bar(
            x=xvalue, y=pricescore,
            text=pricescore,
            textposition='auto',
        )], layout=layout)
fig1.show()

print('Kind of total counts of price: ', wine_csv.shape[0])
print('\n Null: ', nullcnt)

print('\n')
print('4. Variety attribute analysis')
print('\n')
print('The score of the variety which is calculated all of the sum of each varieties score and then divided by the number of the varieties products')
print('\nIf data is Null it is given average score')
print('\nScore of variety')
# average of score for variety
wine_csv["variety"].fillna("Zz No Variety", inplace = True) 
variety_csv = wine_csv.groupby('variety')['score'].mean()
dic = variety_csv.to_dict()
variety = list(dic.keys())
score = list(dic.values())

for i in range(len(score)):
    val = round(score[i],2)
    score[i] = val    

variety1 = {'variety': variety, 'score': score}
df = pd.DataFrame(variety1)
# print(df)
fig = go.Figure(data=[go.Table(
    header=dict(values=df.columns,
                fill_color='paleturquoise',
                align='left'),
    cells=dict(values=[df.variety, df.score],
               fill_color='lavender',
               align='left'))
])
fig.show()

# print('Top 10 of the varieties')
layout = go.Layout(
    title=go.layout.Title(
        text='Top 10 of the varieties'
    ),
    xaxis=go.layout.XAxis(
        title=go.layout.xaxis.Title(
            text='Varieties',
            font=dict(
                family='Courier New, monospace',
                size=18,
                color='#7f7f7f'
            )
        )
    ),
    yaxis=go.layout.YAxis(
        title=go.layout.yaxis.Title(
            text='Score',
            font=dict(
                family='Courier New, monospace',
                size=18,
                color='#7f7f7f'
            )
        )
    )
)
variety_csv4view = variety_csv.sort_values(ascending=False).head(10)
dic = variety_csv4view.to_dict()
variety = list(dic.keys())
score = list(dic.values())

for i in range(len(score)):
    val = round(score[i],2)
    score[i] = val    

variety1 = {'variety': variety, 'score': score}
df = pd.DataFrame(variety1)

fig1 = go.Figure(data=[go.Bar(
            x=variety, y=score,
            text=score,
            textposition='auto',
        )], layout=layout)
fig1.show()

# fig.show()
# average of score for variety
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