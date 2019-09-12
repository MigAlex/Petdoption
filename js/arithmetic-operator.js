// Utworzenie zmiennej subtotal i przeprowadzenie obliczeń.
var subtotal = (13 + 1) * 5; // Subtotal is 70

// Utworzenie zmiennej shipping i przeprowadzenie obliczeń.
var shipping = 0.5 * (13 + 1); // Shipping is 7

// Utworzenie zmiennej total i obliczenie jej wartości przez zsumowanie zmiennych subtotal i shipping.
var total = subtotal + shipping; // Total is 77

// Wyświetlenie wyniku na ekranie.
var elSub = document.getElementById('subtotal');
elSub.textContent = subtotal;

var elShip = document.getElementById('shipping');
elShip.textContent = shipping;

var elTotal = document.getElementById('total');
elTotal.textContent = total;

// Uwaga: textContent nie działa w IE8 i wcześniejszych - wyjaśnienie znajdziesz na WWW.