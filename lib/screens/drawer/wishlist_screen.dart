
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:ghor_chai/Controlers/global_method.dart';
import 'package:ghor_chai/Controlers/providers/wishlist_provider.dart';
import 'package:ghor_chai/screens/drawer/wishlist_widgets.dart';
import 'package:ghor_chai/screens/widgets/custom_widgets.dart';
import 'package:ghor_chai/screens/widgets/test_widgets.dart';
import 'package:provider/provider.dart';



class WishlistScreen extends StatelessWidget {
  static const routeName = "/WishlistScreen";
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;

    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final wishlistItemsList =
    wishlistProvider.getWishlistItems.values.toList().reversed.toList();
    return wishlistItemsList.isEmpty
        ? Center(child: const Text("Empty",style: TextStyle(color: Colors.red,fontSize: 30),))
        : Scaffold(
      appBar: AppBar(
          centerTitle: true,

          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: TextWidget(
            text: 'Wishlist (${wishlistItemsList.length})',
            color: color,
            isTitle: true,
            textSize: 22,
          ),
          actions: [
            IconButton(
              onPressed: () {
                GlobalMethods.warningDialog(
                    title: 'Empty your wishlist?',
                    subtitle: 'Are you sure?',
                    fct: () async {
                      await wishlistProvider.clearOnlineWishlist();
                      wishlistProvider.clearLocalWishlist();
                    },
                    context: context);
              },
              icon: Icon(
                IconlyBroken.delete,
                color: color,
              ),
            ),
          ]),
      body: ListView.builder(
        itemCount: wishlistItemsList.length,
        itemBuilder: (context, index) {
          return ChangeNotifierProvider.value(
            value: wishlistItemsList[index],
            child: const WishlistWidget(),
          );
        },
      ),
    );
  }
}
