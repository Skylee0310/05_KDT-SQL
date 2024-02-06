#pdf - 44p

while True :
    try :
        n = input('숫자를 입력하시오 : ')
        n = int(n)
        break
    except Exception as e :
        print('정수가 아닙니다. : ', e)
        continue
    finally :
        print('finally 구문')
print('정수 입력 성공')