import 'package:flutter/foundation.dart';
import './adoption_cart.dart';


class AdoptionItem {
  final String id;
  final double amount;
  final List<AdoptionCartItem> pets;
  final DateTime dateTime;

  AdoptionItem({
    @required this.id,
    @required this.amount,
    @required this.pets,
    @required this.dateTime,
  });
}

class Adoptions with ChangeNotifier {
  List<AdoptionItem> _adoptions = [];

  List<AdoptionItem> get adoptions {
    return [..._adoptions];
  }

  void addAdoption(List<AdoptionCartItem> cartPets, double total) {
    _adoptions.insert(
      0,
      AdoptionItem(
        id: DateTime.now().toString(),
        amount: total,
        dateTime: DateTime.now(),
        pets: cartPets,
      ),
    );
    notifyListeners();
  }
}
