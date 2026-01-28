todo = {}

print('Добавьте список дел! Для выхода введите 0 в поле Дата')
while True:
    date = input('Дата: ')
    if date == '0':
        break
    todo[date] = input('Задача: ')

print(todo)