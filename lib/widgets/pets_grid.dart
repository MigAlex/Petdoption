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

     var linearGradient = new BoxDecoration(
      gradient: new LinearGradient(
        begin: FractionalOffset.centerRight,
        end: FractionalOffset.bottomLeft,
        colors: [
          Colors.pink,
          Colors.purple,
        ],
      ),
    );

    return Container(
      decoration: linearGradient,
      child: GridView.builder(
        padding: const EdgeInsets.all(5.0),
        itemCount: pets.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: pets[i],
          child: PetItem(
        ),
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.75 / 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
      ),
    );
  }
}
