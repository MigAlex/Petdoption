import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/adoptions.dart' show Adoptions;
import '../widgets/adoption_item.dart';
import '../widgets/app_drawer.dart';

class AdoptionsScreen extends StatelessWidget {
  static const routeName = '/adoptions';
  @override
  Widget build(BuildContext context) {
    final adoptionData = Provider.of<Adoptions>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your adoptions'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: adoptionData.adoptions.length,
        itemBuilder: (ctx, i) => AdoptionItem(adoptionData.adoptions[i]),
      ),
      
    );
  }
}