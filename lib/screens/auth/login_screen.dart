
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ghor_chai/Controlers/helpers/myhelper.dart';
import 'package:ghor_chai/screens/auth/forget_password.dart';
import 'package:ghor_chai/screens/auth/signup_screen.dart';


class LoginScreen extends StatefulWidget {
  
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailTextController = TextEditingController();
  final _passTextController = TextEditingController();
  final _passFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var _obscureText = true;
  @override
  void dispose() {
    _emailTextController.dispose();
    _passTextController.dispose();
    _passFocusNode.dispose();
    super.dispose();
  }

  
  // void _submitFormOnLogin() async {
  //   final isValid = _formKey.currentState!.validate();
  //   FocusScope.of(context).unfocus();

  //   if (isValid) {
  //     _formKey.currentState!.save();
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     try {

  //       Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(
  //           builder: (context) => const FetchScreen(),
  //         ),
  //       );
  //     } on FirebaseException catch (error) {
  //       GlobalMethods.errorDialog(
  //           subtitle: '${error.message}', context: context);
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     } catch (error) {
  //       GlobalMethods.errorDialog(subtitle: '$error', context: context);
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     } finally {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: 
         Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              height: 80.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                 // margin: EdgeInsets.only(right: size.width*0.5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Image.asset(
                    'images/luncher_icon.png',
                    scale: 7,
                  ),
                ),
             
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("GHOR CHAI",style: TextStyle(color: Colors.black,
                      fontSize: 30)),

                    Text("Safe Home\n\t\t\t Safe Rent",style: TextStyle(color: Colors.black,
                      fontSize: 30)),
                   
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    )),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    Align(
                      child: 
                      Text("Login",style: TextStyle(color: Colors.black,fontSize: 18),)
                     
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(_passFocusNode),
                              controller: _emailTextController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty || !value.contains('@')) {
                                  return 'Please enter a valid email address';
                                } else {
                                  return null;
                                }
                              },
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(color: Colors.grey),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green),
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            //Password

                            TextFormField(
                              textInputAction: TextInputAction.done,
                              onEditingComplete: () {
                                
                              },
                              controller: _passTextController,
                              focusNode: _passFocusNode,
                              obscureText: _obscureText,
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value!.isEmpty || value.length < 7) {
                                  return 'Please enter a valid password';
                                } else {
                                  return null;
                                }
                              },
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                    child: Icon(
                                      _obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.black,
                                    )),
                                labelText: 'Password',
                                labelStyle: const TextStyle(color: Colors.grey),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green),
                                ),
                                errorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Foget_PassWord_Screen()));
                        },
                        child: const Text(
                          'Forget password?',
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black
                      ),
                      onPressed: (){
                        var e = _emailTextController.text;
                        var p = _passTextController.text;
                        var obj = MyHelper().sign_in(e, p,context);
                      },
                       child: Text("Login"),),
                    
                     SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            color: Colors.grey,
                            thickness: 2,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text("or",style: TextStyle(color: Colors.black,fontSize: 18),),
                        
                        const SizedBox(
                          width: 5,
                        ),
                        const Expanded(
                          child: Divider(
                            color: Colors.grey,
                            thickness: 2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    // AuthButton(
                    //   fct: () {
                    //     Navigator.of(context).pushReplacement(
                    //       MaterialPageRoute(
                    //         builder: (context) => const FetchScreen(),
                    //       ),
                    //     );
                    //   },
                    //   buttonText: 'Continue as a guest',
                    //   primary: Colors.grey,
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: RichText(
                          text: TextSpan(
                              text: 'Don\'t have an account?',
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 14),
                              children: [
                            TextSpan(
                                text: '  Create Now',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (_)=>RegisterScreen()));
                                  }),
                          ])),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      
    );
  }
}
