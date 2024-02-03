dict_country = {'Seoul': ['South Korea', 'Asia', 9655000],
                'Tokyo': ['Japan', 'Asia', 14110000],
                'Beijing': ['China', 'Asia', 21540000],
                'London': ['United Kingdom', 'Europe', 14800000],
                'Berlin': ['Germany', 'Europe', 3426000],
                'Mexico City': ['Mexico', 'America', 21200000]}


i = 1
# for key, value in dict_country.items() :
#     print(f'[{i}] {key}:{value}')
#     i +=1
# print()
# keylist = sorted(dict_country)
#
# for key in keylist :
#         print(f'[{i}] {key:15} : {dict_country[key][0]:15} {dict_country[key][1]:10} {dict_country[key][2]:,}')
#         i +=1
city = 'London'
i = 1
for key in dict_country.keys() :
    if key in city :
        print(f'도시 : {key}\n'
              f'국가 : {dict_country[key][0]},\t'
              f'대륙 : {dict_country[key][1]},\t'
              f'인구수 : {dict_country[key][2]}')
# valuelist = []
# for key in dict_country.keys() :
#     valuelist.append(dict_country[key][2])
#     valuelist.sort(reverse=True)
#     #print(valuelist)
#     for value in valuelist :
#          if value == dict_country[key][2] :
#              print(value)
def print_population(continent) :
    population = []
    for key in dict_country.keys():
        if dict_country[key][1] == continent :
            population.append(dict_country[key][2])
            print(f'{key} : {dict_country[key][2]}')
    print(f'{continent} 전체 인구수 : {sum(population):,}')

continent = 'Asia'
#continent = input('대륙 이름을 입력하세요 : ')
population =[]
if continent == 'Asia' or continent == 'Europe' or continent =='America' :
    print_population(continent)
    # for key in dict_country.keys() :
    #     if dict_country[key][1] == 'Asia' :
    #         population.append(dict_country[key][2])
    #         print(f'{key} : {dict_country[key][2]}')
    #
    #
    #     if dict_country[key][1] == 'Europe' :
    #         print(f'{key} : {dict_country[key][2]}')
    #
    #
    #     if dict_country[key][1] == 'America' :
    #         print(f'{key} : {dict_country[key][2]}')
    #
    # print(f'{continent} 전체 인구수 : {sum(population):,}')