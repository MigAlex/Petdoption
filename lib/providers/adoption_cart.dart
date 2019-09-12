import 'package:flutter/foundation.dart';

class AdoptionCartItem {
  final String id;
  final String name;
  final double price;

  AdoptionCartItem({
    @required this.id,
    @required this.name,
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
      total += adoptionCartItem.price;
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
        ),
      );
    } else {
      _items.putIfAbsent(
        petId,
        () => AdoptionCartItem(
          id: DateTime.now().toString(),
          name: name,
          price: price,
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

      _items.update(
          petId,
          (existingAdoptionCartItem) => AdoptionCartItem(
                id: existingAdoptionCartItem.id,
                name: existingAdoptionCartItem.name,
                price: existingAdoptionCartItem.price,
              ));
      _items.remove(petId);
    }
    notifyListeners();

  void clear() {
    _items = {};
    notifyListeners();
  }
}
