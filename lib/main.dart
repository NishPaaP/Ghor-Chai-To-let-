import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ghor_chai/Controlers/providers/bottom_nav_provider.dart';
import 'package:ghor_chai/Controlers/providers/cart_provider.dart';
import 'package:ghor_chai/Controlers/providers/order_provider.dart';
import 'package:ghor_chai/Controlers/providers/product_provider.dart';
import 'package:ghor_chai/Controlers/providers/viewpod_provider.dart';
import 'package:ghor_chai/Controlers/providers/wishlist_provider.dart';
import 'package:ghor_chai/screens/auth/welcome_screen.dart';
import 'package:ghor_chai/screens/drawer/order_screen.dart';
import 'package:ghor_chai/screens/drawer/view_recently.dart';
import 'package:ghor_chai/screens/drawer/wishlist_screen.dart';
import 'package:ghor_chai/screens/general/product_details.dart';
import 'package:ghor_chai/screens/home_screen.dart';
import 'package:provider/provider.dart';

import 'screens/drawer/edit_profile.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>ItemProvider()),
        // ChangeNotifierProvider(create: (_) {
        //   return themeChangeProvider;
        // }),
        ChangeNotifierProvider(
          create: (_) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => WishlistProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ViewedProdProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrdersProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => BottomNavigationBarProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: WelcomeScreen(),
        routes: {
          // OnSaleScreen.routeName: (ctx) => const OnSaleScreen(),
          // FeedsScreen.routeName: (ctx) => const FeedsScreen(),
           ProductDetails.routeName: (ctx) => const ProductDetails(),
          WishlistScreen.routeName: (ctx) => const WishlistScreen(),
          OrdersScreen.routeName: (ctx) => const OrdersScreen(),
           ViewedRecentlyScreen.routeName: (ctx) => const ViewedRecentlyScreen(),
          // RegisterScreen.routeName: (ctx) => const RegisterScreen(),
          // LoginScreen.routeName: (ctx) => const LoginScreen(),
          // WelcomeScreen.routeName: (ctx) => const WelcomeScreen(),
          // ForgetPasswordScreen.routeName: (ctx) => const ForgetPasswordScreen(),
           //CategoryScreen.routeName: (ctx) => const CategoryScreen(),
           EditProfileScreen.routeName: (ctx) => const EditProfileScreen(),
        },
      ),
    );
  }
}



class ItemProvider extends ChangeNotifier {
  List<String> items = [];

  void addItem(String item) {
    items.add(item);
    notifyListeners();
  }
}

class UserProvider extends ChangeNotifier {
  String name = '';

  void changeName(String name) {
    this.name = name;
    notifyListeners();
  }
}