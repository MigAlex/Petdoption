import 'package:flutter/material.dart';

class EditPetScreen extends StatefulWidget {
  @override
  _EditPetScreenState createState() => _EditPetScreenState();
}

class _EditPetScreenState extends State<EditPetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Pet annoucement'),
      ),
    );
  }
}
