import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';
class OrderScreen extends StatefulWidget {
  static const routeName = "/order-screen";
       @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _OrderScreen();
  }

}

class _OrderScreen extends State<OrderScreen>
{
  @override
  void initState()
  {
   Future.delayed(Duration.zero).then((_) {
     Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
   } );
    super.initState();
  }

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
