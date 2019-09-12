// Utworzenie zmiennych dla komunikatu powitania.
var greeting = 'Witaj, ';
var name = 'Janku';
var message = ', proszę sprawdź zamówienie:';
// Połączenie wartości trzech powyższych zmiennych i tym samym utworzenie komunikatu powitania.
var welcome = greeting + name + message;

// Utworzenie zmiennych do przechowywania informacji szczegółowych o tabliczce.
var sign = 'Montague House';
var tiles = sign.length;
var subTotal = tiles * 5;
var shipping = 7;
var grandTotal = subTotal + shipping;

// Pobranie elementu, którego atrybut id ma wartość greeting.
var el = document.getElementById('greeting');
// Zastąpienie wartości tego elementu spersonalizowanym komunikatem powitania.
el.textContent = welcome;

// Pobranie elementu, którego atrybut id ma wartość userSign, a następnie uaktualnienie jego zawartości.
var elSign = document.getElementById('userSign');
elSign.textContent = sign;

// Pobranie elementu, którego atrybut id ma wartość tiles, a następnie uaktualnienie jego zawartości.
var elTiles = document.getElementById('tiles');
elTiles.textContent = tiles;

// Pobranie elementu, którego atrybut id ma wartość subTotal, a następnie uaktualnienie jego zawartości.
var elSubTotal = document.getElementById('subTotal');
elSubTotal.textContent = subTotal + ' zł';

// Pobranie elementu, którego atrybut id ma wartość shipping, a następnie uaktualnienie jego zawartości.
var elShipping = document.getElementById('shipping');
elShipping.textContent = shipping + ' zł';

// Pobranie elementu, którego atrybut id ma wartość grandTotal, a następnie uaktualnienie jego zawartości.
var elGrandTotal = document.getElementById('grandTotal');
elGrandTotal.textContent = grandTotal + ' zł';

// Uwaga: textContent nie działa w IE8 i wcześniejszych - wyjaśnienie znajdziesz na WWW.