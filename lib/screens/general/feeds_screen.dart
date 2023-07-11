
import 'package:flutter/material.dart';
import 'package:ghor_chai/Controlers/custom_colors.dart';
import 'package:ghor_chai/Controlers/providers/product_provider.dart';
import 'package:ghor_chai/models/product_model.dart';
import 'package:ghor_chai/screens/widgets/custom_widgets.dart';
import 'package:ghor_chai/screens/widgets/dimentions.dart';
import 'package:ghor_chai/screens/widgets/empty_product_widget.dart';
import 'package:ghor_chai/screens/widgets/feeds_widget.dart';
import 'package:ghor_chai/screens/widgets/size.dart';
import 'package:provider/provider.dart';



class FeedsScreen extends StatefulWidget {
  static const routeName = "/FeedsScreenState";
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  final TextEditingController? _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();
  @override
  void dispose() {
    _searchTextController!.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final productsProvider =
    Provider.of<ProductsProvider>(context, listen: false);
    productsProvider.fetchProducts();
    super.initState();
  }

  List<ProductModel> listProdcutSearch = [];
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final productsProvider = Provider.of<ProductsProvider>(context);
    List<ProductModel> allProducts = productsProvider.getProducts;
    return Scaffold(
      appBar: AppBar(title: Text("All Houses"),centerTitle: true,),
      body: SingleChildScrollView(
        child: Column(children: [
          addVerticalSpace(Dimensions.heightSize),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: kBottomNavigationBarHeight,
              child: TextField(
                focusNode: _searchTextFocusNode,
                controller: _searchTextController,
                onChanged: (valuee) {
                  setState(() {
                    listProdcutSearch = productsProvider.searchQuery(valuee);
                  });
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: CustomColor.primaryColor,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: CustomColor.primaryColor,
                      width: 1,
                    ),
                  ),
                  hintText: "Search by Location",
                  prefixIcon: const Icon(Icons.search),
                  suffix: IconButton(
                    onPressed: () {
                      _searchTextController!.clear();
                      _searchTextFocusNode.unfocus();
                    },
                    icon: Icon(
                      Icons.close,
                      color: _searchTextFocusNode.hasFocus ? Colors.red : color,
                    ),
                  ),
                ),
              ),
            ),
          ),
          _searchTextController!.text.isNotEmpty && listProdcutSearch.isEmpty
              ? const EmptyProdWidget(
              text: 'No products found, please try another keyword')
              : ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            children: List.generate(
                _searchTextController!.text.isNotEmpty
                    ? listProdcutSearch.length
                    : allProducts.length, (index) {
              return ChangeNotifierProvider.value(
                value: _searchTextController!.text.isNotEmpty
                    ? listProdcutSearch[index]
                    : allProducts[index],
                child: const FeedsWidget(),
              );
            }),
          ),
        ]),
      ),
    );
  }
}
