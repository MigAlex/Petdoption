// Utworzenie trzech zmiennych przeznaczonych do przechowywania niezbędnych informacji.
var price;
var quantity;
var total;

// Przypisanie wartości zmiennym price i quantity.
price = 5;
quantity = 14;
// Obliczenie wartości całkowitej przez pomnożenie wartości zmiennych price i quantity.
total = price * quantity;

// Pobranie elementu, którego atrybut id ma wartość cost.
var el = document.getElementById('cost');
el.textContent = total + ' zł';

// Uwaga: textContent nie działa w IE8 i wcześniejszych - wyjaśnienie znajdziesz na WWW.