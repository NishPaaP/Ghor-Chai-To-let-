import 'package:flutter/material.dart';


import 'package:provider/provider.dart';

class Utils {
  BuildContext context;
  Utils(this.context);
 // bool get getTheme => Provider.of<DarkThemeProvider>(context).getDarkTheme;
  Color get color => Colors.black ;
  Size get getScreenSize => MediaQuery.of(context).size;
}
