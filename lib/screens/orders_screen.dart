import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';
class OrderScreen extends StatelessWidget {
  static const routeName = "/order-screen";
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    // TODO: implement build
    return Scaffold( drawer: AppDrawer(),
        appBar: AppBar(
          title: Text("Your Orders"),
        ),
        body: ListView.builder(
            itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
            itemCount: orderData.orders.length));
  }
}
