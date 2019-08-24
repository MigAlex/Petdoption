import 'package:flutter/material.dart';

import '../screens/pet_detail_screen.dart';

class PetItem extends StatelessWidget {
  final String id;
  final String name;
  final String imageUrl;

  PetItem(this.id, this.name, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              PetDetailScreen.routeName,
              arguments: id,
            );
          },
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon: Icon(Icons.favorite),
            color: Theme.of(context).accentColor,
            onPressed: () {},
          ),
          title: Text(
            name,
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
