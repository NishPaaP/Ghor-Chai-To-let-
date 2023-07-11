
import 'package:flutter/material.dart';
import 'package:ghor_chai/Controlers/providers/product_provider.dart';
import 'package:ghor_chai/models/product_model.dart';
import 'package:ghor_chai/screens/widgets/empty_product_widget.dart';
import 'package:ghor_chai/screens/widgets/on_sale_widget.dart';
import 'package:provider/provider.dart';



class OnSaleScreen extends StatelessWidget {
  static const routeName = "/OnSaleScreen";
  const OnSaleScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> productsOnSale = productProviders.getOnSaleProducts;

    return Scaffold(
      appBar: AppBar(title: Text("House on Sell"),centerTitle: true,),

      body: productsOnSale.isEmpty
          ? const EmptyProdWidget(
        text: 'No houses on sale yet!,\nStay tuned',
      )
          : ListView(
        padding: EdgeInsets.zero,
        children: List.generate(productsOnSale.length, (index) {
          return ChangeNotifierProvider.value(
            value: productsOnSale[index],
            child: const OnSaleWidget(),
          );
        }),
      ),
    );
  }
}
