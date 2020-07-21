import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart' as ord;
import '../screens/product_detail_screen.dart';
import '../providers/product.dart';
import 'package:intl/intl.dart';

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;

  OrderItem(this.order);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _OrderItem();
  }
}

class _OrderItem extends State<OrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text("Rs. " + widget.order.amount.toString()),
            subtitle: Text(DateFormat(' dd / MM / yyyy hh:mm')
                .format(widget.order.dateTime)),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container( padding: EdgeInsets.all(10),
              height: widget.order.products.length * 25.0 + 50,
              child: ListView(
                  children: widget.order.products
                      .map((prod) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                prod.title,
                                style: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.bold,),
                              ),
                              Text(
                                prod.quantity.toString() +
                                    "x  " +
                                    prod.price.toString(),
                                style:
                                    TextStyle(fontSize: 18, color: Theme.of(context).primaryColor),
                              )
                            ],
                          ))
                      .toList()),
            )
        ],
      ),
    );
  }
}
