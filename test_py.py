todo = {}

print('Введите команду:\n'
      'help - справка\n'
      'add - добавить задачу\n'
      'show - показать все задачи\n'
      'exit - выход')
while True:
    cmd = input('>: ')
    if cmd == 'exit':
        break
    elif cmd == 'help':
        print('Справка')
    elif cmd == 'add':
        date = input('Дата:')
        task = input('Задача:')
        if date in todo:
            todo[date].append(task)
        else:
            todo[date] = []
            todo[date].append(task)
    elif cmd == 'show':
        print(todo)
    else:
        print('Неверная команда')