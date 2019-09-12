// Powitanie jest przechowywane w zmiennej.
var greeting = 'Witaj, ';

// Nazwa użytkownika jest przechowywana w zmiennej.
var name = 'Janku';

/* Utworzenie komunikatu powitania przez połączenie ciągów tekstowych przechowywanych przez dwie utworzone powyżej zmienne. */
var welcomeMessage = greeting + name + '!';

// Pobranie elementu, którego atrybut id ma wartość greeting.
var el = document.getElementById('greeting');

// Zastąpienie zawartości tego elementu przygotowanym komunikatem.
el.textContent = welcomeMessage;

// Uwaga: textContent nie działa w IE8 i wcześniejszych - wyjaśnienie znajdziesz na WWW.