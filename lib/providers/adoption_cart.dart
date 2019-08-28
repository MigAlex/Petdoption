import 'package:flutter/foundation.dart';

class AdoptionCartItem {
  final String id;
  final String name;
  final int quantity;
  final double price;

  AdoptionCartItem({
    @required this.id,
    @required this.name,
    @required this.quantity,
    @required this.price,
  });
}

class AdoptionCart with ChangeNotifier {
  Map<String, AdoptionCartItem> _items = {};

  Map<String, AdoptionCartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, adoptionCartItem) {
      total += adoptionCartItem.price * adoptionCartItem.quantity;
    });
    return total;
  }

  void addItem(
    String petId,
    double price,
    String name,
  ) {
    if (_items.containsKey(petId)) {
      _items.update(
        petId,
        (existingCartItem) => AdoptionCartItem(
          id: existingCartItem.id,
          name: existingCartItem.name,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        petId,
        () => AdoptionCartItem(
          id: DateTime.now().toString(),
          name: name,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String petId) {
    _items.remove(petId);
    notifyListeners();
  }

  void removeSingleItem(String petId) {
    if (!_items.containsKey(petId)) {
      return;
    }
    if (_items[petId].quantity > 1) {
      _items.update(
          petId,
          (existingAdoptionCartItem) => AdoptionCartItem(
                id: existingAdoptionCartItem.id,
                name: existingAdoptionCartItem.name,
                price: existingAdoptionCartItem.price,
                quantity: existingAdoptionCartItem.quantity - 1,
              ));
    } else {
      _items.remove(petId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
