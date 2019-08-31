import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/adoptions.dart' show Adoptions;
import '../widgets/adoption_item.dart';
import '../widgets/app_drawer.dart';

class AdoptionsScreen extends StatelessWidget{
  static const routeName = '/adoptions';

  @override
  Widget build(BuildContext context) {
    print('building adoptions');
    return Scaffold(
      appBar: AppBar(
        title: Text('Your adoption history'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Adoptions>(context, listen: false).fetchAndSetAdoptions(),
        builder: (ctx, dataSnapshot){
          if(dataSnapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          } else {
            if(dataSnapshot.error != null){
              return Center(child: Text('There is any error!'),
              );
            } else {
              return Consumer<Adoptions> (    //gdy nie ma bledow chcemy zwrocic ListView Adopcji, gdyz mamy zrobiony fetching
                builder: (ctx, adoptionData, child) => ListView.builder(
                  itemCount: adoptionData.adoptions.length,
                  itemBuilder: (ctx, i) => AdoptionItem(adoptionData.adoptions[i]),
                ),
              );
            }
          }
        },
      ),
    );
  }
}