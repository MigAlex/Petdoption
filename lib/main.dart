import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/pets_overview_screen.dart';
import './screens/pet_detail_screen.dart';
import './screens/adoption_cart_screen.dart';
import './providers/pets.dart';
import './providers/adoption_cart.dart';
import './providers/adoptions.dart';
import './providers/auth.dart';
import './screens/adoptions_screen.dart';
import './screens/user_pets_screen.dart';
import './screens/edit_pet_screen.dart';
import './screens/auth_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Pets>(
          builder: (ctx, auth, previousPets) => Pets(
            auth.token,
            auth.userId,
            previousPets == null ? [] : previousPets.items,
          ),
        ),
        ChangeNotifierProvider.value(
          value: AdoptionCart(),
        ),
        ChangeNotifierProxyProvider<Auth, Adoptions>(
          builder: (ctx, auth, previousAdoptions) => Adoptions(
            auth.token,
            previousAdoptions == null ? [] : previousAdoptions.adoptions,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Pet Ads Board',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.lightGreen,
            fontFamily: 'Lato',
          ),
          home: auth.isAuth ? PetsOverviewScreen() : AuthScreen(),
          routes: {
            PetDetailScreen.routeName: (ctx) => PetDetailScreen(),
            AdoptionCartScreen.routeName: (ctx) => AdoptionCartScreen(),
            AdoptionsScreen.routeName: (ctx) => AdoptionsScreen(),
            UserPetsScreen.rounteName: (ctx) => UserPetsScreen(),
            EditPetScreen.routeName: (ctx) => EditPetScreen(),
          },
        ),
      ),
    );
  }
}
