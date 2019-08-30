import 'package:flutter/cupertino.dart';
import './pet.dart';
import 'dart:convert';              //dla konwertowania danych do json (json.encode)

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Pets with ChangeNotifier {
  List<Pet> _items = [
    // Pet(
    //   id: 'p1',
    //   name: 'Pimpek',
    //   description: 'Some funny dog',
    //   price: 0.00,
    //   email: 'elo@gmail.com',
    //   imageUrl: 
    //     'https://st4.depositphotos.com/16122460/21283/i/1600/depositphotos_212838026-stock-photo-funny-dog-big-eyes-white.jpg',
    // ),
    // Pet(
    //   id: 'p2',
    //   name: 'Filemon',
    //   description: 'Lazy Cat at all',
    //   price: 0.00,
    //   email: 'elo@gmail.com',
    //   imageUrl:
    //     'https://image.shutterstock.com/image-photo/lazy-cat-full-asleep-on-260nw-396693610.jpg',
    // ),
    // Pet(
    //   id: 'p3',
    //   name: 'Niszczyciel',
    //   description: 'Royal Dog, excellent for active people',
    //   price: 350.00,
    //   email: 'elo@gmail.com',
    //   imageUrl:
    //     'https://media.istockphoto.com/photos/siberien-husky-dog-in-studio-picture-id516205222?k=6&m=516205222&s=612x612&w=0&h=F7W4GpEYZa0yQTi0u2scDKv6qakA0NbY3ZvMoqYIGAM=',
    // ),
  ];

  List<Pet> get items{
    return [..._items];
  }
  
  List<Pet> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Pet findById(String id){
    return _items.firstWhere((prod) => prod.id == id);
  }
  Future<void> fetchAndSetPets() async{
    const url ='https://petdoption-app.firebaseio.com/pets.json';
    try{
      final response = await http.get(url);
      final unpackedData = json.decode(response.body) as Map<String, dynamic>;      
      final List<Pet> loadedPets = [];
      unpackedData.forEach((ptId, ptData){        //bedzie sie wykonywala petla forEach dla kazdej danej i Peta
        loadedPets.add(Pet(
          id: ptId,
          name: ptData['name'],
          description: ptData['description'],
          price: ptData['price'],
          email: ptData['email'],
          isFavorite: ptData['isFavorite'],
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
    const url ='https://petdoption-app.firebaseio.com/pets.json';
    try{
       final response = await http
        .post(                  //wysyla post request dla url z powyzej
      url,
      body: json.encode({
        'name': pet.name,
        'description': pet.description,
        'price': pet.price,
        'email': pet.email,
        'imageUrl': pet.imageUrl,
        'isFavorite': pet.isFavorite,
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

  void updatePet(String id, Pet newPet) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newPet;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deletePet(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }

}
