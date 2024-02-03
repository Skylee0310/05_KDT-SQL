import pymysql

def printrows():
    print("-"*50)
    rows = cur.fetchall()
    for row in rows :
        print(row)
    print()

def printnum(num) :
    print(f'문제 {num}번')
    print('-'*50)

conn = pymysql.connect(host='localhost', user='root',
                      password='5387',
                      db = 'shoppingmall', charset='utf8')

cur = conn.cursor()
query1 = '''select ut.userName, bt.prodName, ut.addr, concat(ut.mobile1, ut.mobile2) as phone
from user_table as ut inner join buy_table as bt
on ut.userID = bt.userID'''

query2 = '''
select distinct ut.userID, ut.userName, bt.prodName, ut.addr, concat(ut.mobile1, ut.mobile2) as phone
from user_table as ut inner join buy_table as bt
on ut.userID = bt.userID
where ut.userID = 'KYM'
'''
query3 = '''
select ut.userID, ut.userName, bt.prodName, ut.addr, concat(ut.mobile1, ut.mobile2) as '연락'
from user_table as ut inner join buy_table as bt
on ut.userID = bt.userID
order by ut.userID
'''
query4 = '''
select distinct ut.userID, ut.userName, ut.addr
from user_table as ut inner join buy_table as bt
on ut.userID = bt.userID
order by ut.userID'''

query5 = '''select distinct ut.userID, ut.userName, ut.addr, concat(ut.mobile1, ut.mobile2) as '연락'
from user_table as ut inner join buy_table as bt
on ut.userID = bt.userID
where addr = '경북' or addr = '경남'
order by ut.userID'''

ID = "userID"
name = "userName"
prod = "prodName"
addr = "addr"
phone = '연락처'

printnum(1)
print(f"{name:10}{prod:10}{addr:10}{phone:9}")
cur.execute(query1)
printrows()

printnum(2)
print(f"{ID:8}{name:9}{prod:9}{addr:10}{phone:9}")
cur.execute(query2)
printrows()

printnum(3)
print(f"{ID:8}{name:9}{prod:9}{addr:10}{phone:9}")
cur.execute(query3)
printrows()

printnum(4)
print(f"{ID:8}{name:10}{addr:10}")
cur.execute(query4)
printrows()

printnum(5)
print(f"{ID:8}{name:10}{addr:10}{phone:9}")
cur.execute(query5)
printrows()


cur.close()
conn.close()