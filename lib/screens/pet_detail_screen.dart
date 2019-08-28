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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 400,
              width: double.infinity,
              child: Image.network(
                loadedPet.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 11,
            ),
            Text(
              '\$${loadedPet.price}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 21,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              width: double.infinity,
              child: Text(
                loadedPet.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  _createCircleBadge(Icons.email, Colors.lightGreen),
                  Text(
                    loadedPet.email,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _createCircleBadge(IconData iconData, Color color) {
    return new Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: new CircleAvatar(
        backgroundColor: color,
        child: new Icon(
          iconData,
          color: Colors.white,
          size: 16.0,
        ),
        radius: 16.0,
      ),
    );
  }
}
