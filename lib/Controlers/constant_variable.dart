import 'package:firebase_auth/firebase_auth.dart';

class Constss {
  static final List<String> offerImages = [
    "images/Offer1.jpg",
    "images/Offer2.jpg",
    "images/Offer3.jpg",
    "images/Offer4.jpg",
    
  ];
  // static List<String> authImagesPaths = [
  //   'assets/images/landing/buy-on-laptop.jpg',
  //   'assets/images/landing/buy-through.png',
  //   'assets/images/landing/buyfood.jpg',
  //   'assets/images/landing/grocery-cart.jpg',
  //   'assets/images/landing/grocery-cart.jpg',
  //   'assets/images/landing/store.jpg',
  //   'assets/images/landing/vergtablebg.jpg',
  // ];

}



class Assets {
  //bottom bar icon 

  static const String home ='images/home.png';
  static const String search='images/search.png';
  static const String myAds='images/megaphone.png';
  static const String profile='images/profile.png';

  //backIcon
  
  
  //static const String backward='assets/icons/others/backward.svg';
  static const String profileImg='images/profileimg.png';
  
}




final FirebaseAuth authInstance = FirebaseAuth.instance;
// final User? user = authInstance.currentUser;
// final uid = user!.uid;
