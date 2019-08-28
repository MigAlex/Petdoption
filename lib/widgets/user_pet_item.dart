import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_pet_screen.dart';
import '../providers/pets.dart';

class UserPetItem extends StatelessWidget {
  final String id;
  final String name;
  final String imageUrl;

  UserPetItem(this.id, this.name, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 110,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(EditPetScreen.routeName, arguments: id);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: (){
                Provider.of<Pets>(context, listen: false).deletePet(id);
              },
              color: Theme.of(context).errorColor,
            )
          ],
        ),
      ),
    );
  }
}