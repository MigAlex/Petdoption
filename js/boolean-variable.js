// Utworzenie zmiennych i przypisanie im wartości.
var inStock;
var shipping;
inStock = true;
shipping = false;

// Pobranie elementu, którego atrybut id ma wartość stock.
var elStock = document.getElementById('stock');
// Przypisanie atrybutowi class wartości zmiennej inStock.
elStock.className = inStock;

// Pobranie elementu, którego atrybut id ma wartość shipping.
var elShip = document.getElementById('shipping');
// Przypisanie atrybutowi class wartości zmiennej shipping.
elShip.className = shipping;