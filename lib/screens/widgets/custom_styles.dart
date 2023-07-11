import 'package:flutter/material.dart';
import 'package:ghor_chai/Controlers/custom_colors.dart';
import 'package:ghor_chai/screens/widgets/dimentions.dart';

//import 'package:r_dotted_line_border/r_dotted_line_border.dart';


class CustomStyle {
  // Common
  static var commonTextTitle = TextStyle(
    color: CustomColor.primaryTextColor,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static var commonLargeTextTitle = TextStyle(
    color: CustomColor.primaryTextColor,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static var commonSubTextTitle = TextStyle(
    color: CustomColor.primaryTextColor.withOpacity(0.7),
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );

  static var commonMediumSubTextTitle = TextStyle(
    color: CustomColor.primaryTextColor.withOpacity(0.7),
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  // splash screen
  static var splashScreenSubTextTitle = TextStyle(
    color: Colors.black,
    fontSize: Dimensions.mediumTextSize,
    fontWeight: FontWeight.w900,
  );

  // onboard styles
  static var onboardTextTitle = TextStyle(
    color: Colors.white,
    fontSize: Dimensions.mediumTextSize * 1.2,
    fontWeight: FontWeight.w900,
  );
  static var hintTextStyle = TextStyle(
    color: CustomColor.midGrayColor,
    fontSize: Dimensions.smallestTextSize,
    fontWeight: FontWeight.w400,
  );
  static var policyOrUserAgreementTextStyle = TextStyle(
    fontSize: Dimensions.extraSmallTextSize,
    fontWeight: FontWeight.w500,
    color: CustomColor.primaryColor,
  );

  static var appBarTextStyle = TextStyle(
    color: CustomColor.primaryColor,
    fontSize: Dimensions.mediumTextSize,
    fontWeight: FontWeight.w600,
  );
  static var authTitleStyle = TextStyle(
    color: CustomColor.appBarTextColor,
    fontSize: Dimensions.smallestTextSize * 1.2,
    fontWeight: FontWeight.w600,
  );

// Button

  static var secondaryButtonStyle = ElevatedButton.styleFrom(
    elevation: 0,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5))),
  ); // keyboard

  static var keyboardTextStyle = TextStyle(
    color: CustomColor.whiteClr,
    fontSize: Dimensions.extraLargeTextSize * 1.5,
    fontWeight: FontWeight.w700,
  );

  //Drawer

  static var drawerTileTextStyle = TextStyle(
    color: CustomColor.primaryTextColor,
    fontSize: Dimensions.largeTextSize,
    fontWeight: FontWeight.w500,
  );


}