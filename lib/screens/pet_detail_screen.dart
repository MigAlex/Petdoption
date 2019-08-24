import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/pets.dart';

class PetDetailScreen extends StatelessWidget {
  static const routeName = '/pet-detail';

  @override
  Widget build(BuildContext context) {
    final petId =
        ModalRoute.of(context).settings.arguments as String; //to jest id.
    final loadedPet = Provider.of<Pets>(
      context,
      listen: false,
    ).findById(petId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedPet.name),
      ),
    );
  }
}
