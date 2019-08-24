import 'package:flutter/material.dart';

import '../widgets/pets_grid.dart';

class PetsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet Ads Board'),
      ),
      body: new PetsGrid(),
    );
  }
}
