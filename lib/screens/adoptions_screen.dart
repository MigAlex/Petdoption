import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/adoptions.dart' show Adoptions;
import '../widgets/adoption_item.dart';
import '../widgets/app_drawer.dart';

class AdoptionsScreen extends StatefulWidget {  //zamiana na stateful gdyz wtedy mamy initState wraz z future.delayed
  static const routeName = '/adoptions';
  @override
  _AdoptionsScreenState createState() => _AdoptionsScreenState();
}

class _AdoptionsScreenState extends State<AdoptionsScreen> {
  var _isLoading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Adoptions>(context, listen: false)
          .fetchAndSetAdoptions();
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final adoptionData = Provider.of<Adoptions>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your adoption history'),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: adoptionData.adoptions.length,
              itemBuilder: (ctx, i) => AdoptionItem(adoptionData.adoptions[i]),
            ),
    );
  }
}
