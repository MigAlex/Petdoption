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
      itemBuilder: (ctx, i) => ChangeNotifierProvider(
        builder: (c) => pets[i],
        child: PetItem(
      ),
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
