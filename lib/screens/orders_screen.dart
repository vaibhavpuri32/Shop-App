import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = "/order-screen";
  @override
  Widget build(BuildContext context) {
    //final orderData = Provider.of<Orders>(context);
    // TODO: implement build
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text("Your Orders"),
        ),
        body: FutureBuilder(future:
        Provider.of<Orders>(context, listen: false)
            .fetchAndSetOrders(), builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return (Center(child: CircularProgressIndicator(),));
          }

          if (dataSnapshot.error == null) {
            return Consumer<Orders>(builder: (ctx, orderData, child) =>
                ListView.builder(
                    itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
                    itemCount: orderData.orders.length));
          }
          else {
            return Center(child: Text("An Error Occured"));
          }
        },
        ));
  }
}
