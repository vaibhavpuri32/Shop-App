import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';
import 'package:flutter/foundation.dart';
import '../providers/orders.dart';
import '../widgets/app_drawer.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "/cart-screen";

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    // TODO: implement build
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Your Total : ",
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      "Rs . " + cart.totalAmount.toStringAsFixed(2),
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Theme
                        .of(context)
                        .primaryColor,
                  ),
                  FlatButton(
                    child: Text(
                      "ORDER NOW",
                      style: TextStyle(color: Theme
                          .of(context)
                          .primaryColor),
                    ),
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrders(
                          cart.items.values.toList(), cart.totalAmount);
                      cart.clearCart();
                    },
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, i) =>
                  CartItem(
                      id: cart.items.values.toList()[i].id,
                      productid: cart.items.keys.toList()[i],
                      price: cart.items.values.toList()[i].price,
                      quantity: cart.items.values.toList()[i].quantity,
                      title: cart.items.values.toList()[i].title),
              itemCount: cart.itemscount,
            ),
          )
        ],
      ),
    );
  }
}
