# 다중 예외 처리 구조
# 예외 발생한 코드에서 바로 except로 jump
# finally 다음 문장은 예외가 일어나도 반드시 수행해야 한다.


try :
    result = 10/0
except ZeroDivisionError:
    print('오류발생')
finally :
    print('블럭통과')

