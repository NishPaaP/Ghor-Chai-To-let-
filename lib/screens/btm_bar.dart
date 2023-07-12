// ignore_for_file: unnecessary_null_comparison, unused_field

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ghor_chai/Controlers/constant_variable.dart';
import 'package:ghor_chai/Controlers/custom_colors.dart';
import 'package:ghor_chai/Controlers/global_method.dart';
import 'package:ghor_chai/Controlers/providers/bottom_nav_provider.dart';
import 'package:ghor_chai/screens/auth/login_screen.dart';
import 'package:ghor_chai/screens/auth/signup_screen.dart';
import 'package:ghor_chai/screens/bottom_navigation.dart';
import 'package:ghor_chai/screens/drawer/aboutus.dart';
import 'package:ghor_chai/screens/drawer/howtouse.dart';
import 'package:ghor_chai/screens/drawer/wishlist_screen.dart';
import 'package:ghor_chai/screens/postscreens/mainpage.dart';
import 'package:ghor_chai/screens/widgets/dimentions.dart';
import 'package:ghor_chai/screens/widgets/navigatorr.dart';
import 'package:ghor_chai/screens/widgets/size.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';



class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  String? _email;
  String? _name;
  String? address;
  bool _isLoading = false;
  final User? user = authInstance.currentUser;

  @override
  void initState() {
    getConnectivity();
    getUserData();
    super.initState();
  }

  //
  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
            (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          } else {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (ctx) => const BottomBarScreen(),
            ));
          }
        },
      );

  Future<void> getUserData() async {
    setState(() {
      _isLoading = true;
    });
    if (user == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    try {
      String _uid = user!.uid;

      final DocumentSnapshot userDoc =
      await FirebaseFirestore.instance.collection('users').doc(_uid).get();
      if (userDoc == null) {
        return;
      } else {
        _email = userDoc.get('email');
        _name = userDoc.get('name');
        address = userDoc.get('shipping-address');
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });

    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

////
  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
  /////

  @override
  Widget build(BuildContext context) {
    List<String> list = [
      "Name: Kazi Masum\nPhone: 01800000000\nAddress: Ashulia Bazar, Ashulia",
      "Name: Afjal\nPhone: 01744444444\nAddress: Mohakhali Fly Over, Mohakhali",
      "Name: Himel\nPhone: 0181000003\nAddress: 231 Green Road, Dhanmondi",
      'Name: Siam\nPhone: 01772842199\nAddress: Mirpur 2, Mirpur',
      "Name: Yamin\nPhone: 01716756380\nAddress: Banani DOHS, Banani",
      "Name: Fahad\nPhone: 01751884655\nAddress: Gulshan 2, Gulshan",
      "Name: Hasan\nPhone: 01839327941\nAddress: Kallayanpur Bus Stop, Kallayanpur"
    ];
    // final themeState = Provider.of<DarkThemeProvider>(context);
    var controller = Provider.of<BottomNavigationBarProvider>(context);

    //bool isDark = themeState.getDarkTheme;
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              alignment: Alignment.centerLeft,
              width: double.infinity,
              height: 150,
              color: CustomColor.primaryColor.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Image.asset(
                      'images/luncher_icon.png',
                      scale: 10,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('GHOR CHAI',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 15),
                      Text(
                        "Keep Calm and Let's find\nyou A New Home.",
                        style: TextStyle(color: Colors.white),
                        maxLines: 3,
                        overflow: TextOverflow.clip,
                      ),
                    ],
                  )
                ],
              ),
            ),
            _email == null
                ? Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: Dimensions.marginSize * 0.6,
                    vertical: Dimensions.marginSize * 0.6,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'images/LoginOrregister.png',
                        scale: 15,
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (_)=>LoginScreen())
                              );
                            },
                            child: const Text(
                              'Login/',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (_)=>RegisterScreen())
                              );
                            },
                            child: const Text(
                              'Register',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(thickness: 1.5),
              ],
            )
                : Container(),
            const SizedBox(height: 15),
            Visibility(
                visible: _email == null ? false : true,
                child: drawerButton(
                    text: 'Favourite',
                    path: 'images/Favorite.png',
                    onTao: () {
                      GlobalMethods.navigateTo(
                        ctx: context,
                        routeName: WishlistScreen.routeName,
                      );
                    })),
            drawerButton(
                text: 'Contact Us',
                path: 'images/contact.png',
                onTao: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const InfoScreen(
                        title: 'Contact Us',
                      ),
                    ),
                  );
                }),
            drawerButton(
              text: 'Membership',
              path: 'images/membership.png',
              onTao: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const InfoScreen(
                      title: 'Membership',
                    ),
                  ),
                );
              },
            ),
            const Divider(thickness: 1.5),
            drawerButton(
                text: 'About Us',
                path: 'images/Aboutus.png',
                onTao: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const InfoScreen(
                        title: 'About Us',
                      ),
                    ),
                  );
                }),
            drawerButton(
              text: 'Privacy Policy',
              path: 'images/PrivacyPolicy.png',
              onTao: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const InfoScreen(
                      title: 'Terms & Policies',
                    ),
                  ),
                );
              },
            ),
            drawerButton(
              text: 'Electrician',
              path: 'images/MyAds.png',
              onTao: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Electrician(
                      title: 'Electrician',
                      list: list,
                    ),
                  ),
                );
              },
            ),
            drawerButton(
              text: 'Plumber',
              path: 'images/feedbackShare.png',
              onTao: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Electrician(
                      title: 'Plumber',
                      list: list,
                    ),
                  ),
                );
              },
            ),
            drawerButton(
                text: 'How to Use',
                path: 'images/HowtoUse.png',
                onTao: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HowToUseScreen(),
                    ),
                  );
                }),
            addVerticalSpace(Dimensions.heightSize * 3),
            Visibility(
              visible: _email == null ? false : true,
              child: const Divider(thickness: 1.5),
            ),
            Visibility(
              visible: _email == null ? false : true,
              child: ListTile(
                contentPadding:
                EdgeInsets.only(left: Dimensions.marginSize * 2.5),
                leading: Image.asset(
                  'images/logout.png',
                  scale: 15,
                ),
                title: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  GlobalMethods.warningDialog(
                      title: 'Sign out',
                      subtitle: 'Do you wanna sign out?',
                      fct: () async {
                        await authInstance.signOut();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      context: context);
                },
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Ghor Chai"),
        centerTitle: true,
      ),
      extendBody: true,
      backgroundColor: CustomColor.transparent,
      body: controller.page[controller.currentIndex],
      bottomNavigationBar: buildBottomNavigationMenu(context, controller),
      floatingActionButton: _floatingActionButtonWidget(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  drawerButton({
    required String path,
    required String text,
    required VoidCallback onTao,
  }) {
    return ListTile(
      leading: Image.asset(
        path,
        scale: 15,
      ),
      title: Text(
        text,
        style: TextStyle(
          color: text == 'Logout' ? CustomColor.redClr : Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      onTap: onTao,
    );
  }

  showDialogBox() => showCupertinoDialog<String>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      //title: const Text('No Connection'),
      content: Column(
        children: [
          Text("No Internet"),
          // Image.asset("assets/images/internet.png",
          //     height: 250, width: 400, fit: BoxFit.cover),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Opps",
            style: TextStyle(fontSize: 22, color: Colors.amber),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text('No Connection'),
          const Text(
            'Please check your internet connectivity',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            Navigator.pop(context, 'Cancel');
            setState(() => isAlertSet = false);
            isDeviceConnected =
            await InternetConnectionChecker().hasConnection;
            if (!isDeviceConnected && isAlertSet == false) {
              showDialogBox();
              setState(() => isAlertSet = true);
            }
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );

  _floatingActionButtonWidget(BuildContext context) {
    return _isLoading
        ? const CircularProgressIndicator()
        : FloatingActionButton(
      onPressed: () {
        if (_email != null) {
          Navigators.goTo(context, page: const MainPage());
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          );

          // showDialog(
          //   context: context,
          //   builder: (BuildContext context) {
          //     return Column(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         Container(
          //           height: 30,
          //           color: Colors.red,
          //         ),
          //       ],
          //     );
          //   },
          // );
        }
      },
      child: const Icon(Icons.add_rounded,color: Colors.white,),
      backgroundColor:
       CustomColor.primaryColor,
    );
  }
}
