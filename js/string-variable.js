// Utworzenie zmiennych do przechowywania nazwy użytkownika i tekstu notatki.
var username;
var message;
var getOut;

// Przypisanie wartości tym zmiennym.
username = 'Marta';
message = 'Zapoznaj się z naszym nowym asortymentem';
getOut = "I spieprzaj :)";
// Pobranie elementu, którego atrybut id ma wartość name.
var elName = document.getElementById('name');
// Zastąpienie zawartości tego elementu.
elName.textContent = username;

// Pobranie elementu, którego atrybut id ma wartość note.
var elNote = document.getElementById('note');
// Zastąpienie zawartości tego elementu.
elNote.textContent = message;

var elGetOut = document.getElementById('wypad');
elGetOut.textContent = getOut;

// Uwaga: textContent nie działa w IE8 i wcześniejszych - wyjaśnienie znajdziesz na WWW.