import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/pets_grid.dart';
import '../widgets/badge.dart';
import '../providers/adoption_cart.dart';
import './adoption_cart_screen.dart';
import '../widgets/app_drawer.dart';
import '../providers/pets.dart';

enum FilterOptions {
  Favorites,
  All,
}

class PetsOverviewScreen extends StatefulWidget {
  @override
  _PetsOverviewScreenState createState() => _PetsOverviewScreenState();
}

class _PetsOverviewScreenState extends State<PetsOverviewScreen> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {      //uruchamia się raz, gdy laduje dane
    super.initState();
  }

  @override
  void didChangeDependencies() {    //ta metoda odpali sie po pelnym odpaleniu tego calego widgeta
    if (_isInit) {              //odpala się tylko raz, gdy ekran się naładował
      setState(() {
        _isLoading = true;      //loading spinner podczas ladowania listy Petow
      });
      Provider.of<Pets>(context).fetchAndSetPets().then((_) {
        setState(() {
          _isLoading = false;     //fetching pets sie skonczylo
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet Ads Board'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<AdoptionCart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.pets,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(AdoptionCartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading        //jesli sie laduje
          ? Center(
              child: CircularProgressIndicator(),   //pokaz loading spinner
            )
          : PetsGrid(_showOnlyFavorites),   //jak juz nie, pokaz liste petow.
    );
  }
}
