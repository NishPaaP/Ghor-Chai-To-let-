
import 'package:flutter/material.dart';
import 'package:ghor_chai/Controlers/custom_colors.dart';
import 'package:ghor_chai/Controlers/providers/product_provider.dart';
import 'package:ghor_chai/Controlers/providers/wishlist_provider.dart';
import 'package:ghor_chai/models/wishlist_model.dart';
import 'package:ghor_chai/screens/general/product_details.dart';
import 'package:ghor_chai/screens/widgets/custom_widgets.dart';
import 'package:ghor_chai/screens/widgets/dimentions.dart';
import 'package:ghor_chai/screens/widgets/heart_button.dart';
import 'package:ghor_chai/screens/widgets/size.dart';
import 'package:provider/provider.dart';


class WishlistWidget extends StatelessWidget {
  const WishlistWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    final wishlistModel = Provider.of<WishlistModel>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final getCurrProduct =
    productProvider.findProdById(wishlistModel.productId);
    double usedPrice = getCurrProduct.isOnSale
        ? getCurrProduct.salePrice
        : getCurrProduct.price;
    bool? _isInWishlist =
    wishlistProvider.getWishlistItems.containsKey(getCurrProduct.id);
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
          onTap: () {
            //Navigator.push(context,MaterialPageRoute(builder: (_)=>ProductDetails()));
            Navigator.pushNamed(context, ProductDetails.routeName,
                arguments: wishlistModel.productId);
          },
          child: Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(
              horizontal: Dimensions.marginSize * 0.4,
              vertical: Dimensions.marginSize * 0.4,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius * 1.5),
            ),
            child: Theme(
              data: ThemeData(dividerColor: CustomColor.transparent),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  vertical: Dimensions.marginSize * 0.4,
                  horizontal: 0,
                ),
                title: Row(
                  crossAxisAlignment: crossStart,
                  children: [
                    addHorizontalSpace(Dimensions.widthSize),
                    Expanded(
                      flex: 0,
                      child: ClipRRect(
                        child: Image.network(
                          getCurrProduct.imageUrl,
                          fit: BoxFit.cover,
                          height: 140,
                          width: 115,
                        ),
                        borderRadius: BorderRadius.circular(Dimensions.radius),
                      ),
                    ),
                    addHorizontalSpace(Dimensions.widthSize * 1.2),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: crossStart,
                        children: [
                          Text(
                            getCurrProduct.productCategoryName,
                            style: TextStyle(
                              color: color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            getCurrProduct.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: color.withOpacity(0.6),
                              fontSize: Dimensions.mediumTextSize * 0.9,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(right: 60),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    getCurrProduct.description,
                                    textAlign: TextAlign.left,
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: color,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                addHorizontalSpace(Dimensions.widthSize * 0.4),
                                Expanded(
                                  flex: 0,
                                  child: HeartBTN(
                                    productId: getCurrProduct.id,
                                    isInWishlist: _isInWishlist,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "৳ ${getCurrProduct.price} / Monthly",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: CustomColor.primaryColor,
                              fontSize: Dimensions.mediumTextSize,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
