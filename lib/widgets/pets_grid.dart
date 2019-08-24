import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/pets.dart';
import './pet_item.dart';

class PetsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final petsData = Provider.of<Pets>(context);
    final pets = petsData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(5.0),
      itemCount: pets.length,
      itemBuilder: (ctx, i) => PetItem(
        pets[i].id,
        pets[i].name,
        pets[i].imageUrl,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
