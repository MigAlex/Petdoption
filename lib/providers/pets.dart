import 'package:flutter/cupertino.dart';
import './pet.dart';

class Pets with ChangeNotifier {
  List<Pet> _items = [
    Pet(
      id: 'p1',
      name: 'Pimpek',
      description: 'Some funny dog',
      price: 0.00,
      imageUrl: 
        'https://st4.depositphotos.com/16122460/21283/i/1600/depositphotos_212838026-stock-photo-funny-dog-big-eyes-white.jpg',
    ),
    Pet(
      id: 'p2',
      name: 'Filemon',
      description: 'Lazy Cat at all',
      price: 0.00,
      imageUrl:
        'https://image.shutterstock.com/image-photo/lazy-cat-full-asleep-on-260nw-396693610.jpg',
    ),
    Pet(
      id: 'p3',
      name: 'Niszczyciel',
      description: 'Royal Dog, excellent for active people',
      price: 350.00,
      imageUrl:
        'https://media.istockphoto.com/photos/siberien-husky-dog-in-studio-picture-id516205222?k=6&m=516205222&s=612x612&w=0&h=F7W4GpEYZa0yQTi0u2scDKv6qakA0NbY3ZvMoqYIGAM=',
    ),
  ];

  List<Pet> get items{
    return [..._items];
  }

  void addPet(){
    //_items.add();
    notifyListeners();
  }

  Pet findById(String id){
    return _items.firstWhere((prod) => prod.id == id);
  }
}
