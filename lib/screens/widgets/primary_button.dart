import 'package:flutter/material.dart';
import 'package:ghor_chai/Controlers/custom_colors.dart';
import 'package:ghor_chai/screens/widgets/dimentions.dart';



class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.borderColorName = CustomColor.primaryColor,
    this.borderWidth = 0,
    this.radius = 7,
    this.height,
    this.buttonColor = CustomColor.primaryColor,
    this.buttonTextColor =  Colors.white,
  }) : super(key: key);
  final String title;
  final VoidCallback onPressed;
  final Color borderColorName;
  final double borderWidth;
  final double? height;
  final double radius;
  final Color buttonColor;
  final Color buttonTextColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? Dimensions.buttonHeight * 0.8,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        
          side: BorderSide(
            width: borderWidth,
            color: borderColorName,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: Dimensions.mediumTextSize,
            color: buttonTextColor,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
