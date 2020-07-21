import 'package:flutter/material.dart';
import '../providers/cart.dart';
import 'package:provider/provider.dart';
class CartItem extends StatelessWidget {
  final String id;
  final String productid;
  final double price;
  final int quantity;
  final String title;

  CartItem({this.id, this.productid,this.price, this.quantity, this.title});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Dismissible(
        key: ValueKey(id), direction: DismissDirection.endToStart,
        onDismissed: (direction) {

          Provider.of<Cart>(context,listen: false).removeItem(productid);



        },
        background: Container(
          color: Theme.of(context).errorColor,
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        ),
        child: (Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          child: Padding(
              padding: EdgeInsets.all(2),
              child: ListTile(
                leading: CircleAvatar(
                  child: Padding(
                      padding: EdgeInsets.all(5),
                      child: FittedBox(
                        child: Text("${price}"),
                      )),
                ),
                title: Text("${title}"),
                subtitle: Text("Rs. " + "${price * quantity}"),
                trailing: Text("${quantity}x"),
              )),
        )));
  }
}
