// ignore_for_file: unused_field, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ghor_chai/Controlers/constant_variable.dart';
import 'package:ghor_chai/Controlers/custom_colors.dart';
import 'package:ghor_chai/Controlers/global_method.dart';
import 'package:ghor_chai/screens/general/fetch_screen.dart';
import 'package:ghor_chai/screens/widgets/custom_inputs.dart';
import 'package:ghor_chai/screens/widgets/custom_widgets.dart';
import 'package:ghor_chai/screens/widgets/dimentions.dart';
import 'package:ghor_chai/screens/widgets/primary_button.dart';
import 'package:ghor_chai/screens/widgets/size.dart';



class EditProfileScreen extends StatefulWidget {
  static const routeName = "/CategoryScreenStateEditProfileScreen";
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final formKey = GlobalKey<FormState>();

  final emailTextController = TextEditingController();

  final nameController = TextEditingController();
  final _addressTextController = TextEditingController();

  @override
  void dispose() {
    _addressTextController.dispose();
    super.dispose();
  }

  String? _email;
  String? _name;
  String? address;
  bool _isLoading = false;
  final User? user = authInstance.currentUser;
  @override
  void initState() {
    getUserData();
    super.initState();
  }

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
        emailTextController.text = userDoc.get('email');
        nameController.text = userDoc.get('name');
        address = userDoc.get('shipping-address');
        _addressTextController.text = userDoc.get('shipping-address');
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      GlobalMethods.errorDialog(subtitle: '$error', context: context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text("Edit Profile"),
          centerTitle: true,
        ),
        bottomNavigationBar: _buttonWidget(context),

    );
  }

  _bodyWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(Dimensions.marginSize * 0.6),
      child: ListView(
        children: [
          _profilePicture(),
          addVerticalSpace(Dimensions.heightSize),
          _inputWidget(context),
        ],
      ),
    );
  }

  _profilePicture() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(Dimensions.defaultPaddingSize * 0.1),
          margin: EdgeInsets.only(top: Dimensions.marginSize * 1.5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: CustomColor.borderColor, width: 4),
          ),
          child: CircleAvatar(
            radius: Dimensions.radius * 7.2,
            backgroundColor: CustomColor.primaryColor.withOpacity(0.6),
            backgroundImage: const AssetImage(Assets.profileImg),
          ),
        ),
      ],
    );
  }

  _inputWidget(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          children: [
            CustomInputWidget(
              labelText: 'Full Name',
              hintText: 'Enter Your Name',
              controller: nameController,
            ),
            CustomInputWidget(
              labelText: 'Address',
              hintText: 'Enter Address',
              controller: _addressTextController,
            ),
            CustomInputWidget(
              labelText: 'Email Address',
              hintText: 'Enter Email Address',
              controller: emailTextController,
              readOnly: true,
            ),
          ],
        ));
  }

  _buttonWidget(BuildContext context) {
    //bool isDark = Utils(context).getTheme;
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
        boxShadow:
             [
          const BoxShadow(
            color: CustomColor.lightGrayColor,
            blurRadius: 1,
            spreadRadius: 1,
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: PrimaryButton(
        title: 'Update',
        onPressed: () async {
          String _uid = user!.uid;
          try {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(_uid)
                .update({
              'shipping-address': _addressTextController.text,
              'name': nameController.text,
            });

            setState(() {
              address = _addressTextController.text;
              _name = nameController.text;
            });Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const FetchScreen(),
              ),
            );

          } catch (err) {
            GlobalMethods.errorDialog(
                subtitle: err.toString(), context: context);
          }


        },
      ),
    );
  }
}
