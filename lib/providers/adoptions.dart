import 'package:flutter/foundation.dart';
import './adoption_cart.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;


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

  Future <void> addAdoption(List<AdoptionCartItem> cartPets, double total) async {
    const url ='https://petdoption-app.firebaseio.com/adoptions.json';
    final timing = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        'amount': total,
        'dateTime': timing.toIso8601String(),
        'pets': cartPets
        .map((cp) => {
          'id': cp.id,
          'name': cp.name,
          'quantity': cp.quantity,
          'price': cp.price,
        }).toList(),
      }),
    );
    _adoptions.insert(
      0,
      AdoptionItem(
        id: json.decode(response.body)['name'],         //autogenerowane id dla tej adopcji
        amount: total,
        dateTime: timing,
        pets: cartPets,
      ),
    );
    notifyListeners();
  }

  Future<void> fetchAndSetAdoptions() async{
    const url ='https://petdoption-app.firebaseio.com/adoptions.json';
    final response = await http.get(url);
    final List<AdoptionItem> loadedAdoptions = [];
    final unpackedData = json.decode(response.body) as Map<String, dynamic>;
    if(unpackedData == null){
      return;
    }
    unpackedData.forEach((adoptionId, adoptionData){
      loadedAdoptions.add(
        AdoptionItem(
          id: adoptionId,
          amount: adoptionData['amount'],
          dateTime: DateTime.parse(adoptionData['dateTime']),
          pets: (adoptionData['pets'] as List<dynamic>)
          .map(
            (item) => AdoptionCartItem(
              id: item['id'],
              price: item['price'],
              quantity: item['quantity'],
              name: item['name'],
            ),
          ).toList(),
        ),
      );
    });
    _adoptions = loadedAdoptions.reversed.toList(); //tak by w historii adopcji na samej gorze były najnowsze
    notifyListeners();
  }
}
