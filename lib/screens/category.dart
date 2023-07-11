// ignore_for_file: must_be_immutable

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:ghor_chai/screens/widgets/category_widget.dart';
import 'package:ghor_chai/screens/widgets/dimentions.dart';

class CategoriesScreen extends StatelessWidget {
   CategoriesScreen({Key? key}) : super(key: key);

 final List<Color> gridColors = [
    const Color(0xff53B175),
    const Color(0xffF8A44C),
    const Color(0xffF7A593),
    const Color(0xffD3B0E0),
    const Color(0xffFDE598),
    const Color(0xffB7DFF5),
  ];

List<Map<String, dynamic>> catInfo = [
    {
      'imgPath': 'images/tolet.png',
      'catText': 'To-Let',
    },
    {
      'imgPath': 'images/flat.png',
      'catText': 'Flat',
    },
    {
      'imgPath': 'images/plot.png',
      'catText': 'Plot',
    },
    {
      'imgPath': 'images/duplex.png',
      'catText': 'Duplex',
    },
    {
      'imgPath': 'images/hostel.png',
      'catText': 'Hostel',
    },
     {
      'imgPath': 'images/hotel.png',
      'catText': 'Hotel',
    },
  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
     
        body: Container(
          margin: EdgeInsets.only(top: Dimensions.heightSize),
          child: Padding(
            padding:  EdgeInsets.all(Dimensions.marginSize*0.4),
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 500 / 200,
              crossAxisSpacing: 15, // Vertical spacing
              mainAxisSpacing: 15, // Horizontal spacing 
              children: List.generate(6, (index) {
                return CategoriesWidget(
                  catText: catInfo[index]['catText'],
                  imgPath: catInfo[index]['imgPath'],
                  passedColor: gridColors[index],
                );
              }),
            ),
          ),
        ));
  }
}
