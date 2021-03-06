import 'dart:convert'; 

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Pet with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final double price;
  final String email;
  final String imageUrl;
  bool isFavorite;

  Pet({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.price,
    @required this.email,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void _setFavoriteValue(bool newValue){
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String token, String userId) async{
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url ='https://petdoption-app.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';
    try {
      final response = await http.put(
        url,
        body: json.encode(
          isFavorite,
        ),
      );
      if (response.statusCode >= 400) {
        _setFavoriteValue(oldStatus);
      }
    } catch (error) {
      _setFavoriteValue(oldStatus);
    }
  }
}