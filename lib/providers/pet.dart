import 'package:flutter/foundation.dart';

import 'dart:convert';          //dla json.encode
import 'package:http/http.dart' as http;

class Pet with ChangeNotifier{
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

  Future<void> toggleFavoriteStatus() async{
    final previousStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url ='https://petdoption-app.firebaseio.com/pets/$id.json';
    try {
      final response = await http.patch(
        url,
        body: json.encode({'isFavorite': isFavorite,}),
      );
      if(response.statusCode >= 400){
        _setFavoriteValue(previousStatus);
      }
    } catch (error){
      _setFavoriteValue(previousStatus);
    }
  }

  void _setFavoriteValue(bool newValue){
    isFavorite = newValue;
    notifyListeners();
  }
}