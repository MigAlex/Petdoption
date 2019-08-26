import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/adoption_cart.dart' show AdoptionCart;
import '../widgets/adoption_cart_item.dart';
import '../providers/adoptions.dart';

class AdoptionCartScreen extends StatelessWidget {
  static const routeName = '/adoptionCart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<AdoptionCart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Pet Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(16),
            child: Padding(
              padding: EdgeInsets.all(7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 21),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.title.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    child: Text('Adopt it now!'),
                    onPressed: () {
                      Provider.of<Adoptions>(context, listen: false).addAdoption(
                        cart.items.values.toList(),
                        cart.totalAmount,
                      );
                      cart.clear();
                    },
                    textColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, i) => AdoptionCartItem(
                cart.items.values.toList()[i].id,
                cart.items.keys.toList()[i],
                cart.items.values.toList()[i].price,
                cart.items.values.toList()[i].quantity,
                cart.items.values.toList()[i].name,
              ),
            ),
          )
        ],
      ),
    );
  }
}
