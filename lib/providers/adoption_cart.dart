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
}
