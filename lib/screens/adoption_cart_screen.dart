import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/adoption_cart.dart' show AdoptionCart;
import '../widgets/adoption_cart_item.dart';
import '../providers/adoptions.dart';

class AdoptionCartScreen extends StatelessWidget {
  static const routeName = '/adoptionCart';

  @override
  Widget build(BuildContext context) {
    final adoptionCart = Provider.of<AdoptionCart>(context);
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
                      '\$${adoptionCart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.title.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                 AdoptionButton(adoptionCart: adoptionCart)
                ],
              ),
            ),
          ),
          SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: adoptionCart.items.length,
              itemBuilder: (ctx, i) => AdoptionCartItem(
                adoptionCart.items.values.toList()[i].id,
                adoptionCart.items.keys.toList()[i],
                adoptionCart.items.values.toList()[i].price,
                adoptionCart.items.values.toList()[i].name,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AdoptionButton extends StatefulWidget {     //adoptionbutton bedzie uzywany tylko w powyzszym widgecie, wiec nie ma co go przenosic do osobnego pliku
  const AdoptionButton({
    Key key,
    @required this.adoptionCart,
  }) : super(key: key);

  final AdoptionCart adoptionCart;

  @override
  _AdoptionButtonState createState() => _AdoptionButtonState();
}

class _AdoptionButtonState extends State<AdoptionButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: _isLoading ? CircularProgressIndicator() : Text('Adopt it!'),
      onPressed: (widget.adoptionCart.totalAmount <= 0 || _isLoading) ? null : () async {
        setState(() {
         _isLoading = true; 
        });
        await Provider.of<Adoptions>(context, listen: false).addAdoption(
          widget.adoptionCart.items.values.toList(),
          widget.adoptionCart.totalAmount,
          );
          setState(() {
           _isLoading = false; 
          });
          widget.adoptionCart.clear();
      },
      textColor: Theme.of(context).primaryColor,    
    );
  }
}