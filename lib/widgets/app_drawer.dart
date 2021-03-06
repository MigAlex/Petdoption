import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/adoptions_screen.dart';
import '../screens/user_pets_screen.dart';
import '../providers/auth.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Welcome!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),                        //po kolei każda opcja w appbarze, tu powrot do listy petow
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Pet List View'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),                      //przejscie do ekranu historii
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Adoptions history'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AdoptionsScreen.routeName);
            },
          ),
          Divider(),          //przejscie do ekranu dodawania/edycji Twoich ogloszen
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Your Pet annoucements'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(UserPetsScreen.routeName);
            },
          ),
          Divider(),          //przejscie do ekranu dodawania/edycji Twoich ogloszen
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Log out'),
            onTap: () {
              Navigator.of(context).pop();      //do zamkniecia panelu bocznego
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
      
    );
  }
}