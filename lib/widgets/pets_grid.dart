import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/pets.dart';
import './pet_item.dart';

class PetsGrid extends StatelessWidget {
  final bool showFavorites;

  PetsGrid(this.showFavorites);

  @override
  Widget build(BuildContext context) {
    final petsData = Provider.of<Pets>(context);
    final pets = showFavorites ? petsData.favoriteItems : petsData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(5.0),
      itemCount: pets.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: pets[i],
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
