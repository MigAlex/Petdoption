import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/pet_detail_screen.dart';
import '../providers/pet.dart';
import '../providers/adoption_cart.dart';
import '../providers/auth.dart';

class PetItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pet = Provider.of<Pet>(context, listen: false);
    final adoptionCart = Provider.of<AdoptionCart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
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
                    product.toggleFavoriteStatus(authData.token);
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
            onPressed: () {
              adoptionCart.addItem(pet.id, pet.price, pet.name);
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'You have already added pet to adoption cart',
                  ),
                  duration: Duration(seconds: 3),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: (){
                      adoptionCart.removeSingleItem(pet.id);
                    },
                  ),
                ),

              );
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
