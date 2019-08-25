import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/pets_grid.dart';
import '../widgets/badge.dart';
import '../providers/adoption_cart.dart';

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
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: PetsGrid(_showOnlyFavorites),
    );
  }
}
