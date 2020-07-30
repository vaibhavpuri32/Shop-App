import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';
import '../screens/edit_product_screen.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = "/User-Product-Screen";

  Future<void> _refreshProduct(BuildContext ctx) async {
     await Provider.of<Products>(ctx).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    // TODO: implement build
    return (Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text("Your Products"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshProduct(context),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
              itemBuilder: (_, index) => Column(
                    children: [
                      UserProductItem(
                          productData.items[index].id,
                          productData.items[index].title,
                          productData.items[index].imageUrl),
                      Divider()
                    ],
                  ),
              itemCount: productData.items.length),
        ),
      ),
    ));
  }
}
