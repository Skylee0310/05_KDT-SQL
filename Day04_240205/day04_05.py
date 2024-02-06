def calc(values) :
    sum = None
    sum = values[0] + values[1] + values[2]

    print(f'sum={sum}')

def calc1(values) :
    sum = None
    try :
        sum = values[0] + values[1] + values[2]
    except IndexError as e :
        print('IndexError : ', e)
    except Exception as e :
        print(e)
    finally :
        print(f'sum = {sum}')

#calc([1.2])
calc1([1,2])