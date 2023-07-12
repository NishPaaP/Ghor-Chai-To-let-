
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ghor_chai/Controlers/constant_variable.dart';
import 'package:ghor_chai/Controlers/custom_colors.dart';
import 'package:ghor_chai/Controlers/global_method.dart';
import 'package:ghor_chai/screens/widgets/custom_inputs.dart';
import 'package:ghor_chai/screens/widgets/custom_widgets.dart';
import 'package:ghor_chai/screens/widgets/dimentions.dart';
import 'package:ghor_chai/screens/widgets/primary_button.dart';



class ForgetPasswordScreen extends StatefulWidget {
  static const routeName = '/ForgetPasswordScreen';
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _emailTextController = TextEditingController();
  // bool _isLoading = false;
  @override
  void dispose() {
    _emailTextController.dispose();

    super.dispose();
  }

  bool _isLoading = false;
  void _forgetPassFCT() async {
    if (_emailTextController.text.isEmpty ||
        !_emailTextController.text.contains("@")) {
      GlobalMethods.errorDialog(
          subtitle: 'Please enter a correct email address', context: context);
    } else {
      setState(() {
        _isLoading = true;
      });
      try {
        await authInstance.sendPasswordResetEmail(
            email: _emailTextController.text.toLowerCase());
        Fluttertoast.showToast(
          msg: "An email has been sent to your email address",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey.shade600,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } on FirebaseException catch (error) {
        GlobalMethods.errorDialog(
            subtitle: '${error.message}', context: context);
        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        GlobalMethods.errorDialog(subtitle: '$error', context: context);
        setState(() {
          _isLoading = false;
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    return Scaffold(
      appBar: AppBar(title: Text("Forget Password"),centerTitle: true,),

      bottomNavigationBar:_buttonWidget(context),
      body:  Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              CustomInputWidget(
                labelText: 'Email Address',
                hintText: 'Enter Your Email',
                controller: _emailTextController,
              ),
              const SizedBox(
                height: 15,
              ),

            ],
          ),
        ),

    );
  }

  _buttonWidget(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(
        top: Dimensions.marginSize,
        bottom: Dimensions.marginSize,
        left: Dimensions.marginSize * 0.6,
        right: Dimensions.marginSize * 0.6,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.radius * 1.5),
          topRight: Radius.circular(Dimensions.radius * 1.5),
        ),
        boxShadow: [BoxShadow(
            color: CustomColor.lightGrayColor,
            blurRadius: 1,
            spreadRadius: 1,
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: PrimaryButton(
        title: 'Reset now',
        onPressed: () {
          _forgetPassFCT();
        },
      ),
    );
  }
}
