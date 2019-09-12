// Utworzenie i nadanie nazwy zmiennej.
// Poinformowanie interpretera, że zmienna jest tablicę.
// Przypisanie wartości odbywa się w nawiasie.
var colors = new Array('biały', 
						'czarny',
						'inny');
// Wyświetlenie pierwszego elementu tablicy.
var el = document.getElementById('colors');
el.textContent = colors[0];

// Uwaga: textContent nie działa w IE8 i wcześniejszych - konieczne jest użycie innerHTML.