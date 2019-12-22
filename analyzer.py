# import xlrd
#
# loc = ("testdata.xlsx")
#
# wb = xlrd.open_workbook(loc)
# sheet = wb.sheet_by_index(0)
#
# print(sheet.cell_value(0, 0))

import sqlite3
import os.path

# BASE_DIR = os.path.dirname(os.path.abspath(__file__))
BASE_DIR = os.path.dirname(os.path.abspath(''))
db_path = os.path.join(BASE_DIR, "testdata.db")

conn = sqlite3.connect(db_path)
cursor = conn.cursor()
cursor.execute('select count(*) from review')
result = cursor.fetchone()
print('Total records: ', result[0])

cursor.execute('select * from ( select rid, avg(rating) aveg from review group by rid ) order by aveg desc')
upcount = 0
ridarr = []
for row in cursor:
    print(row[0], row[1])
    if row[0] == 1:
        break
    ridarr.append(row[0])
    upcount = upcount+1

print('Count having bigger rate: ', upcount)
cursor.execute('select * from review where rid=?', (1,))
tastecount1 = 0
cleancount1 = 0
atmocount1 = 0
loccount1 = 0
pricecount1 = 0
totcount = 0
# seascount1 = 0
row = cursor.fetchone()

for row in cursor:
    rating = row[4]
    reviewcontent = row[9]
    totcount+=1
    # print(rid, row[1])
    if reviewcontent is not None:
        # print(reviewcontent.count('taste'), reviewcontent.count('clean'), reviewcontent.count('atmosphere'), reviewcontent.count('location'))
        tastecount1+=reviewcontent.count('delicious')
        tastecount1+=reviewcontent.count('juicy')
        cleancount1+=reviewcontent.count('clean')
        atmocount1+=reviewcontent.count('atmosphere')
        loccount1+=reviewcontent.count('location')
        loccount1+=reviewcontent.count('place')
        pricecount1+=reviewcontent.count('price')
        pricecount1+=reviewcontent.count('budget')
        # seascount1+=reviewcontent.count('season')
        # seascount1+=reviewcontent.count('spring')
        # seascount1+=reviewcontent.count('summer')
        # seascount1+=reviewcontent.count('autumn')
        # seascount1+=reviewcontent.count('winter')
print("Current restaurant factors")
tastecount1 = tastecount1/totcount
cleancount1 = cleancount1/totcount
atmocount1 = atmocount1/totcount
loccount1 = loccount1/totcount
pricecount1 = pricecount1/totcount
# seascount1 = seascount1/totcount
# print('1', tastecount1, cleancount1, atmocount1, loccount1, pricecount1, seascount1)
print('1', tastecount1, cleancount1, atmocount1, loccount1, pricecount1)

uptaste = 0
upclean = 0
upatmo = 0
uploc = 0
upprice = 0
# upseason = 0
for rd in ridarr:
    t = (rd,)
    cursor.execute('select * from review where rid=?', t)
    # row = cursor.fetchone();
    # print(row[0])
    tastecount = 0
    cleancount = 0
    atmocount = 0
    loccount = 0
    pricecount = 0
    # seascount = 0
    totcount = 0
    for row in cursor:
        rid = row[0]
        rating = row[4]
        reviewcontent = row[9]
        totcount+=1
        # print(rid, row[1])
        if reviewcontent is not None:
            # print(reviewcontent.count('taste'), reviewcontent.count('clean'), reviewcontent.count('atmosphere'), reviewcontent.count('location'))
            tastecount += reviewcontent.count('delicious')
            tastecount += reviewcontent.count('juicy')
            cleancount+=reviewcontent.count('clean')
            atmocount+=reviewcontent.count('atmosphere')
            loccount+=reviewcontent.count('location')
            loccount+=reviewcontent.count('place')
            pricecount+=reviewcontent.count('price')
            pricecount+=reviewcontent.count('budget')
            # seascount+=reviewcontent.count('season')
            # seascount+=reviewcontent.count('spring')
            # seascount+=reviewcontent.count('summer')
            # seascount+=reviewcontent.count('autumn')
            # seascount+=reviewcontent.count('winter')
    tastecount = tastecount / totcount
    cleancount = cleancount/totcount
    atmocount = atmocount/totcount
    loccount = loccount/totcount
    pricecount = pricecount/totcount
    # seascount = seascount/totcount
    # print(rid, tastecount, cleancount, atmocount, loccount, pricecount, seascount)
    print(rid, tastecount, cleancount, atmocount, loccount, pricecount)
    if tastecount>tastecount1:
        uptaste+=1
    if cleancount>cleancount1:
        upclean+=1
    if atmocount>atmocount1:
        upatmo+=1
    if loccount>loccount1:
        uploc+=1
    if pricecount>pricecount1:
        upprice+=1
    # if seascount>seascount1:
    #     upseason+=1

print("")
print("Factor Percentage")
print("Taste Percentage: ", format(uptaste/upcount*100, '.2f'), '%')
print("Clean Percentage: ", format(upclean/upcount*100, '.2f'), '%')
print("Atmosphere Percentage: ", format(upatmo/upcount*100, '.2f'), '%')
print("Location Percentage: ", format(uploc/upcount*100, '.2f'), '%')
print("Price Percentage: ", format(upprice/upcount*100, '.2f'), '%')

print("Impact order is Price, Clean, Taste, Atmosphere and the Location is the last.")

# print("")
# print("Seasonal Impact: ", format(upseason/upcount*100, '.2f'), '%')
# print("It seems that seasonal impact is not important.")

seascount = [0, 0, 0, 0, 0]
cursor.execute('select * from review order by rating')
for row in cursor:
    rating = row[4]
    reviewcontent = row[9]
    if reviewcontent is not None:
        seascount[rating-1]+=reviewcontent.count('season')
        seascount[rating-1]+=reviewcontent.count('spring')
        seascount[rating-1]+=reviewcontent.count('summer')
        seascount[rating-1]+=reviewcontent.count('autumn')
        seascount[rating-1]+=reviewcontent.count('winter')
seassum = 0
for i in range(0, 5):
    seassum += seascount[i]

print("")
print("Season Factor Percentage")
for i in range(0, 5):
    print("Rating ", i+1, ": ", format(seascount[i]/seassum*100, '.2f'), '%')

print("This shows that seasonal impact is somewhat important.")



cursor.execute('select * from review order by numberofuseful desc limit 0, 10')
print("")
print("Comments having best Number of useful")
for row in cursor:
    print("")
    print(row[9])

cursor.execute('select * from review order by numberofcool desc limit 0, 10')
print("")
print("Comments having best Number of cool")
for row in cursor:
    print("")
    print(row[9])

cursor.execute('select * from review order by numberoffunny desc limit 0, 10')
print("")
print("Comments having best Number of funny")
for row in cursor:
    print("")
    print(row[9])

nofcount = [0, 0, 0, 0, 0]
for i in range(0, 5):
    cursor.execute('select avg(user_numberoffriends) from review where rating=?', (i+1,))
    row = cursor.fetchone()
    nofcount[i] = row[0]

print("")
print("Number of friends Impact")
for i in range(0, 5):
    print("Rating ", i+1, ": ", format(nofcount[i], '.2f'))
print("This shows that number of friends impact is not so important.")


cursor.execute('select * from review order by numberoffunny desc limit 0, 10')
print("")
print("Comments having best Number of reviews")
for row in cursor:
    print("")
    print(row[9])
conn.close()