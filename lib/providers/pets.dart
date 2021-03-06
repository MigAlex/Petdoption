import 'dart:convert';        //dla konwertowania danych do json (json.encode)

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import './pet.dart';

class Pets with ChangeNotifier {
  List<Pet> _items = [ ];
  final String authToken;
  final String userId;

  Pets(this.authToken, this.userId, this._items);

  List<Pet> get items{
    return [..._items];
  }
  
  List<Pet> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Pet findById(String id){
    return _items.firstWhere((prodItem) => prodItem.id == id);
  }
  Future<void> fetchAndSetPets([bool filterByUser = false]) async{
    final filterString = filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url ='https://petdoption-app.firebaseio.com/pets.json?auth=$authToken&$filterString';
    try{
      final response = await http.get(url);
      final unpackedData = json.decode(response.body) as Map<String, dynamic>;
      if(unpackedData == null){
        return;
      }
      url ='https://petdoption-app.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
      final favoriteResponse = await http.get(url); 
      final favoriteData = json.decode(favoriteResponse.body);     
      final List<Pet> loadedPets = [];
      unpackedData.forEach((ptId, ptData){        //bedzie sie wykonywala petla forEach dla kazdej danej i Peta
        loadedPets.add(Pet(
          id: ptId,
          name: ptData['name'],
          description: ptData['description'],
          price: ptData['price'],
          email: ptData['email'],
          isFavorite: favoriteData == null ? false : favoriteData[ptId] ?? false,
          imageUrl: ptData['imageUrl'],
        ));
      });
      _items = loadedPets;    //teraz to bedzie lista Petow zamiast tych lokalnych powyzej
      notifyListeners();    //dla poinformowania wszystkich miejsc w apce, na ktore to wplywa
    } catch(error){
      throw(error);
    }
  }

  Future<void> addPet(Pet pet) async {
    final url ='https://petdoption-app.firebaseio.com/pets.json?auth=$authToken';
    try{
       final response = await http.post(                  //wysyla post request dla url z powyzej
      url,
      body: json.encode({
        'name': pet.name,
        'description': pet.description,
        'price': pet.price,
        'email': pet.email,
        'imageUrl': pet.imageUrl,
        'creatorId': userId,
      }),
    );
      final newPet = Pet(
        name: pet.name,
        description: pet.description,
        price: pet.price,
        email: pet.email,
        imageUrl: pet.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newPet);
      notifyListeners();
    } catch (error){
      print(error);
      throw error;
    }

  }
//chcemy edytowac peta o szczegolnym id dlatego to $id
//patch request przekaze Firebase ze nalezy to merge dane ktore nadejda w tym updacie do istniejacych juz danych
  Future <void> updatePet(String id, Pet newPet) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url ='https://petdoption-app.firebaseio.com/pets/$id.json?auth=$authToken';   
     await http.patch(url,
     body: json.encode({
       'name': newPet.name,
       'description': newPet.description,
       'price': newPet.price,
       'email': newPet.email,
       'imageUrl': newPet.imageUrl,
     }));
     
      _items[prodIndex] = newPet;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future <void> deletePet(String id) async {
    final url ='https://petdoption-app.firebaseio.com/pets/$id.json?auth=$authToken';
    final existingPetIndex = _items.indexWhere((pt) => pt.id == id);
    var existingPet = _items[existingPetIndex];
    _items.removeAt(existingPetIndex);                  //kasuje z listy, ale nie z pamieci
    notifyListeners();

    final response = await http.delete(url);
    if (response.statusCode >= 400){
      _items.insert(existingPetIndex, existingPet);
      notifyListeners();
      throw HttpException('Unable to delete pet!');
    }
    existingPet = null;
  }

}
