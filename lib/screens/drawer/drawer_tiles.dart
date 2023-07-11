import 'package:flutter/material.dart';
import 'package:ghor_chai/screens/widgets/custom_widgets.dart';
import 'package:ghor_chai/screens/widgets/test_widgets.dart';





class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.press,
    required this.icon,
  }) : super(key: key);

  final String title;
  final VoidCallback press;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    
    final color =  Colors.white ;

    return ListTile(
        onTap: press,
        horizontalTitleGap: 0.0,
        leading: Icon(
          icon,
          size: 24,
        ),
        title: TextWidget(
          text: title,
          color: color,
          textSize: 24,
        ));
  }
}