# 예외처리 1 : 프로그램이 비정상 종료되지 않고 예외 처리 문장을 수행함.
(x,y) = (2, 0)
try :
    z = x/y
except ZeroDivisionError:
    print('0으로 나누는 예외') # 사용자 예외 출력문


(x, y) = (2,0)
try :
    z = x/y
except ZeroDivisionError as e : # e ---> 발생한 예외에 대한 정보를 가지고 있음.
    print(e) #파이썬이 제공하는 예외 메시지 출력.

    