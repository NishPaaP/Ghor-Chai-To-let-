
import 'package:flutter/material.dart';
import 'package:ghor_chai/screens/auth/login_screen.dart';


class WelcomeScreen extends StatelessWidget {
  static const routeName = '/WelcomeScreen';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            'GHOR CHAI',
            style: TextStyle(
                color: Colors.greenAccent,
                fontWeight: FontWeight.w700,
                fontSize: 40),
          ),
          const SizedBox(height: 20),
          const Text(
            'Safe Home',
            style: TextStyle(
                color: Colors.red, fontWeight: FontWeight.w700, fontSize: 25),
          ),
          const SizedBox(height: 8),
          const Text(
            'Safe Rent',
            style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.w700,
                fontSize: 25),
          ),
          SizedBox(height: size.height*0.16,),

          Align(
            alignment: Alignment.center,
            child: Container(
              height: size.height*0.3,
              width: size.width*0.5,
              decoration: BoxDecoration(
                //color: Colors.amber
                image: DecorationImage(image: AssetImage("images/luncher_icon.png"))
              ),
          
            ),
          ),
          SizedBox(height: size.height*0.1,),
          Align(
              alignment: Alignment.center,
              child: InkWell(
                radius: 10,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  margin:
                  const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  width: double.infinity,
                  height: 49,
                  alignment: Alignment.center,
                  child: const Text(
                    'Get Started!',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15)),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>LoginScreen()));
                },
              ))
        ],
      ),
    );
  }
}
