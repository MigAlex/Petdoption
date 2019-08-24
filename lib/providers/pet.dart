import 'package:flutter/foundation.dart';

//struktura jak wygląda Zwierzak

class Pet with ChangeNotifier{
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Pet({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,

  });

  void toggleFavoriteStatus(){
    isFavorite = !isFavorite;
    notifyListeners();
  }
}