import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/pets_overview_screen.dart';
import './screens/pet_detail_screen.dart';
import './providers/pets.dart';
import './providers/adoption_cart.dart';
import './screens/adoption_cart_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Pets(),
        ),
        ChangeNotifierProvider.value(
          value: AdoptionCart(),
        ),
      ],
      child: MaterialApp(
        title: 'Pet Ads Board',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.lightGreen,
          fontFamily: 'Lato',
        ),
        home: PetsOverviewScreen(),
        routes: {
          PetDetailScreen.routeName: (ctx) => PetDetailScreen(),
          AdoptionCartScreen.routeName: (ctx) => AdoptionCartScreen(),
        },
      ),
    );
  }
}
