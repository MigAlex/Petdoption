import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/pet_detail_screen.dart';
import '../providers/pet.dart';

class PetItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pet = Provider.of<Pet>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              PetDetailScreen.routeName,
              arguments: pet.id,
            );
          },
          child: Image.network(
            pet.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Pet>(
            builder: (ctx, product, child) => IconButton(
                  icon: Icon(
                    product.isFavorite ? Icons.favorite : Icons.favorite_border,
                  ),
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    product.toggleFavoriteStatus();
                  },
                ),
          ),
          title: Text(
            pet.name,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.pets,
            ),
            onPressed: () {},
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
