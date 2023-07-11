import 'package:flutter/material.dart';
import 'package:ghor_chai/Controlers/constant_variable.dart';
import 'package:ghor_chai/Controlers/custom_colors.dart';
import 'package:ghor_chai/screens/widgets/dimentions.dart';
import 'package:ghor_chai/screens/widgets/size.dart';
import 'package:provider/provider.dart';

// import 'package:flutter_svg/svg.dart';



buildBottomNavigationMenu(context, bottomNavBarController) {
  //final themeState = Provider.of<DarkThemeProvider>(context);

  //bool isDark = themeState.getDarkTheme;
  return Container(
    height: 65,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      color: CustomColor.transparent,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(Dimensions.radius * 2.5),
        topRight: Radius.circular(Dimensions.radius * 2.5),
      ),
      // boxShadow: const [  //todo you want to add 'Box Shadow?
      //   BoxShadow(
      //     color: Color.fromARGB(26, 53, 52, 52),
      //     blurRadius: 1.0,
      //     spreadRadius: 1.0,
      //   )
      // ],
    ),
    child: BottomAppBar(
      elevation: 0,
      shape: const CircularNotchedRectangle(),
      notchMargin: 7,
      color:  CustomColor.primaryColor,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            bottomItemWidget(
                Assets.home, 'Home', bottomNavBarController, 0, ),
            bottomItemWidget(
                Assets.search, 'Search', bottomNavBarController, 1, ),
            addHorizontalSpace(Dimensions.widthSize),
            bottomItemWidget(
                Assets.myAds, 'My Ads', bottomNavBarController, 2, ),
            bottomItemWidget(
                Assets.profile, 'PROFILE', bottomNavBarController, 3, ),
          ],
        ),
      ),
    ),
  );
}

bottomItemWidget(var icon, label, bottomNavBarController, page, ) {
  return InkWell(
    onTap: () {
      bottomNavBarController.currentIndex = page;
    },
    child: Column(
      children: [
        Image.asset(
          icon,
          scale: bottomNavBarController.currentIndex == page ? 22 : 23,
          color:bottomNavBarController.currentIndex == page
                  ? CustomColor.whiteClr
                  : CustomColor.whiteClr.withOpacity(0.30)
              
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: Dimensions.smallestTextSize,
            color:  bottomNavBarController.currentIndex == page
                  ? CustomColor.whiteClr
                  : CustomColor.whiteClr.withOpacity(0.30)
              
          ),
        ),
      ],
    ),
  );
}
