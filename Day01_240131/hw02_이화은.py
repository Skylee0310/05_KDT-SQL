'''
1. 큰 틀을 먼저 만들고 종료버튼이 작동하는지 확인.
2.
'''


# 프로그램 종료(6번)를 입력할 때까지 선택지 출력 반복.
#-> 번호 입력/프린트문 출력은 계속 while문 안에 넣어서 반복해야 함.
# 1. 입력 값이 숫자인지 검사
# 2. 입력 값이 숫자이고 1~6사이라면 해당 메뉴 실행 후 다시 프린트문
'''
1. 전체 데이터 출력 -
2. 수도 이름 오름차순 출력
3. 모든 도시의 인구수 내림차순 출력
4. 특정 도시의 정보 출력
5. 대륙별 인구수 계산 및 출력
6. 프로그램 종료 ㅇ
'''
dict_country = {'Seoul': ['South Korea', 'Asia', 9655000],
                'Tokyo': ['Japan', 'Asia', 14110000],
                'Beijing': ['China', 'Asia', 21540000],
                'London': ['United Kingdom', 'Europe', 14800000],
                'Berlin': ['Germany', 'Europe', 3426000],
                'Mexico City': ['Mexico', 'America', 21200000]}
# 함수 1 선택지 출력
def print_choice() : # 메뉴를 출력하는 함수.
    print('-'*50)
    print('1. 전체 데이터 출력\n'
          '2. 수도 이름 오름차순 출력\n'
          '3. 모든 도시의 인구수 내림차순 출력\n'
          '4. 특정 도시의 정보 출력\n'
          '5. 대륙별 인구수 계산 및 출력\n'
          '6. 프로그램 종료')
    print('-'*50)

# 함수2 입력한 대륙에 속한 나라의 인구수와 그 합을 출력하는 함수
def print_population(continent):
    population = []
    for key in dict_country.keys():
        if dict_country[key][1] == continent:
            population.append(dict_country[key][2])
            print(f'{key} : {dict_country[key][2]:,}')
    print(f'{continent} 전체 인구수 : {sum(population):,}')


while True :
    print_choice()
    choice = input("메뉴를 입력하세요 : ")
    if choice.isdecimal() :
        choice = int(choice)

        i = 1 #인덱스에 사용할 값 1로 지정.

        # [번호] 키 : 값 출력.
        if choice == 1 :
            for key, value in dict_country.items():
                print(f'[{i}] {key}: {value}')
                i += 1
        # 수도 이름 오름차순 출력.

        elif choice == 2 :
            keylist = sorted(dict_country)
            for key in keylist:
                print(f'[{i}] {key:15} : {dict_country[key][0]:15} {dict_country[key][1]:10} {dict_country[key][2]:,}')
                i += 1

        elif choice == 3 :
            n = 0
            dict2 = sorted(dict_country.values(), key=lambda x: x[2], reverse=True)
            for v in dict2 :
                for key, value in dict_country.items() :
                    if value == v :
                        print(f'[{i}] {key} : {value[2]:,}')
                        i+=1
            # for key, value in dict_country.items() :
            #     for v in dict2 :
            #         if value[2] == v[2] :


        elif choice == 4 :
            city = input('출력할 도시의 이름을 입력하세요 : ')
            if city in dict_country.keys() :
                print(f'도시 : {city}\n'
                      f'국가 : {dict_country[city][0]},\t'
                      f'대륙 : {dict_country[city][1]},\t'
                      f'인구수 : {dict_country[city][2]:,}')
            else :
                print(f'도시이름: {city}은 key에 없습니다.')

        elif choice == 5 :
            continent = input('대륙 이름을 입력하세요 : ')
            print_population(continent)

        elif choice == 6 :
            print('프로그램을 종료합니다.')
            break
        else :
            print('숫자를 입력해주세요.')


