
import 'package:flutter/material.dart';
import 'package:ghor_chai/Controlers/constant_variable.dart';
import 'package:ghor_chai/Controlers/custom_colors.dart';
import 'package:ghor_chai/Controlers/global_method.dart';
import 'package:ghor_chai/Controlers/providers/product_provider.dart';
import 'package:ghor_chai/models/product_model.dart';
import 'package:ghor_chai/screens/bottom_navigation.dart';
import 'package:ghor_chai/screens/drawer/drawer_tiles.dart';
import 'package:ghor_chai/screens/general/feeds_screen.dart';
import 'package:ghor_chai/screens/general/on_sale_screen.dart';
import 'package:ghor_chai/screens/widgets/custom_styles.dart';
import 'package:ghor_chai/screens/widgets/feeds_widget.dart';
import 'package:ghor_chai/screens/widgets/on_sale_widget.dart';
import 'package:provider/provider.dart';

import 'widgets/custom_widgets.dart';
import 'widgets/dimentions.dart';
import 'widgets/size.dart';
import 'widgets/test_widgets.dart';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_iconly/flutter_iconly.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    productsProvider.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final Color color = Utils(context).color;
    Size size = utils.getScreenSize;
    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> allProducts = productProviders.getProducts;
    List<ProductModel> productsOnSale = productProviders.getOnSaleProducts;
    return Scaffold(




      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: mainMin,
          children: [
            /// slider
            SizedBox(
              height: size.height * 0.25,
              child:

              Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Image.asset(
                    Constss.offerImages[index],
                    fit: BoxFit.fill,
                  );
                },
                autoplay: true,
                itemCount: Constss.offerImages.length,
                pagination: const SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  builder: DotSwiperPaginationBuilder(
                    color: Colors.white,
                    activeColor: CustomColor.primaryColor,
                  ),
                ),
                // control: const SwiperControl(color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 12,
            ),

            const Divider(
              thickness: 2,
            ),

            ///view all button
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      TextWidget(
                        text: 'top WANTED'.toUpperCase(),
                        color: Colors.red,
                        textSize: 18,
                        isTitle: true,
                      ),
                      addHorizontalSpace(Dimensions.widthSize),
                      const Icon(

                        IconlyLight.image,
                        color: Colors.red,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: TextButton(
                      onPressed: () {
                        GlobalMethods.navigateTo(
                            ctx: context, routeName: OnSaleScreen.routeName);
                      },
                      child: TextWidget(
                        text: 'View all',
                        maxLines: 1,
                        color: CustomColor.primaryColor,
                        textSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 6,
            ),

            /// first row .. home view
            Flexible(
              child: SizedBox(
                height: null,
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    reverse: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:
                        productsOnSale.length < 10 ? productsOnSale.length : 10,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (ctx, index) {
                      return ChangeNotifierProvider.value(
                        value: productsOnSale[index],
                        child: const OnSaleWidget(),
                      );
                    }
    ),
              ),
            ),

            const Divider(
              thickness: 2,
            ),

            ///browse all button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: 'Homes and Hotels',
                    color: color,
                    textSize: 22,
                    isTitle: true,
                  ),
                  // const Spacer(),
                  TextButton(
                    onPressed: () {
                      GlobalMethods.navigateTo(
                          ctx: context, routeName: FeedsScreen.routeName);
                    },
                    child: TextWidget(
                      text: 'Browse all',
                      maxLines: 1,
                      color: CustomColor.primaryColor,
                      textSize: 20,
                    ),
                  ),
                ],
              ),
            ),

            ///grid view product view
            ListView(
              shrinkWrap: true,
              reverse: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              children: List.generate(
                  allProducts.length < 10
                      ? allProducts.length // length 3
                      : 10, (index) {
                return ChangeNotifierProvider.value(
                  value: allProducts[index],
                  child: const FeedsWidget(),
                );
              }),
            ),
            const SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    );
  }
}
