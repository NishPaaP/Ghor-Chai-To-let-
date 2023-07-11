import 'package:flutter/material.dart';
import 'package:ghor_chai/screens/category.dart';
import 'package:ghor_chai/screens/general/user.dart';
import 'package:ghor_chai/screens/home_screen.dart';
import 'package:ghor_chai/screens/postscreens/allproduct_screen.dart';



class BottomNavigationBarProvider with ChangeNotifier {
  int _currentIndex = 0;

  get currentIndex => _currentIndex;

  set currentIndex(var index) {
    _currentIndex = index;
    notifyListeners();
  }

  final List page = [
    const HomeScreen(),
    CategoriesScreen(),
    const AllProductList(),
    const UserScreen(),
  ];
}

