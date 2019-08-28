import 'package:flutter/material.dart';

class UserPetItem extends StatelessWidget {
  final String name;
  final String imageUrl;

  UserPetItem(this.name, this.imageUrl);

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
                //will add in future
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: (){
                //will add in future
              },
              color: Theme.of(context).errorColor,
            )
          ],
        ),
      ),
    );
  }
}