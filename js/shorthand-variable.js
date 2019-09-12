// Metoda 1.
var price = 5;
var quantity = 14;
var total = price * quantity;

/* Metoda 2.
var price, quantity, total;
price = 5;
quantity = 14;
total = price * quantity;
*/

/* Metoda 3.
var price = 5, quantity = 14;
var total = price * quantity;
*/

// Umieszczenie wartości zmiennej total w elemencie, którego atrybut id ma wartość cost.
var el = document.getElementById('cost');  // Pobranie elementu, którego atrybut id ma wartość cost.
el.textContent = total + ' zł';                // Zastąpienie zawartości tego elementu.


// Uwaga: textContent nie działa w IE8 i wcześniejszych - wyjaśnienie znajdziesz na WWW.