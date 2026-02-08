spisok = ['python', 'c++', 'c', 'scala', 'java']
naiti = 'c'
counter = 0

for word in spisok:
    counter += word.count(naiti)

print('Количество вхождений [',naiti,'] в списке =',counter)
