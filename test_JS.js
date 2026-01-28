let messages = [
    "Пойдем гулять в парк?",
    "Кажется, дождь собирается. Лучше пойдем в кино!",
    "Давай, сегодня как раз вышел новый фильм.",
    "Встречаемся через час у кинотеатра."
]

let slovo = 'кино'

for(let i = 0; i < messages.length; i++) {
    if (messages[i].includes(slovo) == true) {
        console.log('Есть! ' + messages[i])
    }
}

