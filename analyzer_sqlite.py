import sqlite3
import os.path
import csv

try:
    BASE_DIR = os.path.dirname(os.path.abspath(__file__))
except NameError:
    import sys
    BASE_DIR = os.path.dirname(os.path.abspath(sys.argv[0]))

# BASE_DIR = os.path.dirname(os.path.abspath(''))
# conn = sqlite3.connect('C:\\Users\\User\\Desktop\\wineanalyzer_src\\wine.db')
# BASE_DIR = 'C:\\Users\\User\\Desktop\\wineanalyzer_src\\';
db_path = os.path.join(BASE_DIR, "wine.db")

conn = sqlite3.connect(db_path)
cursor = conn.cursor()

cursor.execute('select count(*) from winetable')
result = cursor.fetchone()
# print('Total records: ', result[0])
print('--- Top 100 Wines ---')

cursor.execute('select state, round(cast(avg(score) as numeric), 2) ascore from winetable group by state order by state')
statescore = {}
for row in cursor:
    # print(row[0], row[1])
    statescore[row[0]] = row[1]

# outfile = open(os.path.join(BASE_DIR, "statescore.csv"), "w", encoding="utf-8", newline='\n')
# csvout = csv.writer(outfile)
# csvout.writerow(['state','score'])
# for k in statescore.keys():
#     newrow = [k, statescore[k]]
#     csvout.writerow(newrow)

# outfile.close()

cursor.execute('select variety, round(cast(avg(score) as numeric), 2) ascore from winetable group by variety order by variety')
varietyscore = {}
for row in cursor:
    # print(row[0], row[1])
    varietyscore[row[0]] = row[1]

# outfile = open(os.path.join(BASE_DIR, "varietyscore.csv"), "w", encoding="utf-8", newline='\n')
# csvout = csv.writer(outfile)
# csvout.writerow(['variety','score'])
# for k in varietyscore.keys():
#     newrow = [k, varietyscore[k]]
#     csvout.writerow(newrow)
#
# outfile.close()

cursor.execute('select id, title, score, price, state, variety from winetable')

ucursor = conn.cursor()

totscore = 0.0
count = 0
for row in cursor:
    totscore = row[2]*4
    if row[3] is not None:
        if row[3] > 300:
            totscore = totscore + 1 * 3
        elif row[3] > 230:
            totscore = totscore + 2 * 3
        elif row[3] > 100:
            totscore = totscore + 3 * 3
        elif row[3] > 50:
            totscore = totscore + 4 * 3
        else:
            totscore = totscore + 5 * 3
    for k in statescore.keys():
        if k==row[4]:
            totscore = totscore + statescore[k] * 1.5
            break
    for k in varietyscore.keys():
        if k==row[5]:
            totscore = totscore+varietyscore[k]*1.5
            break
    ucursor.execute('update winetable set totalscore=? where id=?',(round(totscore/10,2), row[0]))
    conn.commit()
    print(row[1], (round(totscore/10,2)))
    count = count+1
    if count==100:
        break

# csvout = open(os.path.join(BASE_DIR, "wineout.csv"), "w", encoding="utf-8")
outfile = open(os.path.join(BASE_DIR, "wineout.csv"), "w", encoding="utf-8", newline='\n')
csvout = csv.writer(outfile)
# csvout.write("id,country,title,score,price,state,region_1,region_2,variety,winery,totalscore")
csvout.writerow(['id','country','title','score','price','state','region_1','region_2','variety','winery','totalscore'])
cursor.execute('select * from winetable order by totalscore desc')
for row in cursor:
    newrow = []
    for i in range(11):
        if row[i] is not None:
            if ( type(row[i]) is str ):
                newrow.append(row[i])
            else:
                newrow.append(str(row[i]))
        else:
            newrow.append('')
    csvout.writerow(newrow)

outfile.close()
conn.close()