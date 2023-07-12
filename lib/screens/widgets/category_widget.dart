
import 'package:flutter/material.dart';
import 'package:ghor_chai/screens/general/cat_screen.dart';
import 'package:ghor_chai/screens/widgets/dimentions.dart';
import 'package:ghor_chai/screens/widgets/test_widgets.dart';
import 'package:provider/provider.dart';



class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({
    Key? key,
    required this.catText,
    required this.imgPath,
    required this.passedColor,
  }) : super(key: key);
  final String catText, imgPath;
  final Color passedColor;
  @override
  Widget build(BuildContext context) {
   // final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color =  Colors.white ;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, CategoryScreen.routeName,
            arguments: catText);
      },
      child: Container(
        decoration: BoxDecoration(
          color: passedColor,
          borderRadius: BorderRadius.circular(Dimensions.radius * 1.8),
        ),
        child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(imgPath, scale: 20),
              const SizedBox(width: 10),
              TextWidget(
                text: catText,
                color: color,
                textSize: 20,
                isTitle: true,
              ),
            ]),
      ),
    );
  }
}
