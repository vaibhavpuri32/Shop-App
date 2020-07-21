import 'package:cart/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/badge.dart';
import '../widgets/products_grid.dart';
import '../providers/cart.dart';
import '../screens/Cart_screen.dart';
import '../widgets/app_drawer.dart';
enum FilterOptions {
  favourites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductsOverviewScreen();
  }
}

class _ProductsOverviewScreen extends State<ProductsOverviewScreen> {
  var _showFavouritesOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold( drawer: AppDrawer(),
      appBar: AppBar(
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedvalue) {
              setState(() {
                if (selectedvalue == FilterOptions.favourites) {
                  _showFavouritesOnly = true;
                } else {
                  _showFavouritesOnly = false;
                }
              });
            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text("Only Favourites"),
                value: FilterOptions.favourites,
              ),
              PopupMenuItem(
                child: Text("Show All"),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemscount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          )
        ],
        title: Text('My Shop'),
      ),
      body: ProductsGrid(_showFavouritesOnly),
    );
  }
}
