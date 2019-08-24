import 'package:flutter/material.dart';

class PetDetailScreen extends StatelessWidget {
  static const routeName = '/pet-detail';

  @override
  Widget build(BuildContext context) {
    final petId =
        ModalRoute.of(context).settings.arguments as String; //to jest id.
    return Scaffold(
      appBar: AppBar(
        title: Text('name'),
      ),
    );
  }
}
