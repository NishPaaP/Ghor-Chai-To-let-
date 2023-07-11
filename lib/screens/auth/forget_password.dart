
import 'package:flutter/material.dart';

import 'package:ghor_chai/screens/widgets/custom_inputs.dart';





class Foget_PassWord_Screen extends StatefulWidget {
  const Foget_PassWord_Screen({super.key});

  @override
  State<Foget_PassWord_Screen> createState() => _Foget_PassWord_ScreenState();
}

class _Foget_PassWord_ScreenState extends State<Foget_PassWord_Screen> {

final _emailTextController = TextEditingController();
  // bool _isLoading = false;
  @override
  void dispose() {
    _emailTextController.dispose();

    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("Forget Password"),centerTitle: true,),

      //bottomNavigationBar:_buttonWidget(context),
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

}