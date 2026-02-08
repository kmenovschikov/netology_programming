# Сначала создать бот через BotFather
import telebot
token = 'suda_api_token'
bot = telebot.TeleBot(token)

todo = {}
HELP = '/help - справка \n/add - добавить задачу \n/show - показать все задачи'

@bot.message_handler(commands=['help'])
def help(message):
    bot.send_message(message.chat.id, HELP)

@bot.message_handler(commands=['add'])
def add(message):
    date = message.text.split(maxsplit=2)[1]
    task = message.text.split(maxsplit=2)[2]
    if date in todo:
        todo[date].append(task)
    else:
        todo[date] = []
        todo[date].append(task)
    bot.send_message(message.chat.id, 'Задача добавлена!')

@bot.message_handler(commands=['show'])
def show(message):
    bot.send_message(message.chat.id, str(todo))

# Запрашиваем сообщения у ТГ постоянно (типа бесконечный цикл)
bot.polling(none_stop=True)
