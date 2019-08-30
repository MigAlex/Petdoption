import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/pets.dart';
import '../widgets/user_pet_item.dart';
import '../widgets/app_drawer.dart';
import './edit_pet_screen.dart';

class UserPetsScreen extends StatelessWidget {
  static const rounteName = '/user-pets';

  Future<void> _refreshPets(BuildContext context) async {
    await Provider.of<Pets>(context).fetchAndSetPets();
  }

  @override
  Widget build(BuildContext context) {
    final petsData = Provider.of<Pets>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Pets Annoucements'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditPetScreen.routeName);
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(       //widget dzieki ktoremu po przeciagnieciu w dol w 'Your Pets Annoucements' odswiezy nam sie lista Petow
        onRefresh: () => _refreshPets(context),
        child: Padding(
          padding: EdgeInsets.all(9),
          child: ListView.builder(
            itemCount: petsData.items.length,
            itemBuilder: (_, i) => Column(
              children: [
                UserPetItem(
                  petsData.items[i].id,
                  petsData.items[i].name,
                  petsData.items[i].imageUrl,
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
