

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ghor_chai/screens/auth/signup_screen.dart';
import 'package:ghor_chai/screens/general/fetch_screen.dart';
import 'package:ghor_chai/screens/home_screen.dart';
import 'package:ghor_chai/screens/postscreens/mainpage.dart';

class MyHelper{
  Future sign_up(email,password,context) async{
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if(credential.user!.uid.isNotEmpty){
        Navigator.push(context,MaterialPageRoute(builder: (_)=>RegisterScreen()));
      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
  Future sign_in(email,password,context) async{
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if(credential.user!.uid.isNotEmpty){
        Navigator.push(context,MaterialPageRoute(builder: (_)=>FetchScreen()));
      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
    }
  }
}