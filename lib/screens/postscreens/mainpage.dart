// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ghor_chai/Controlers/custom_colors.dart';
import 'package:ghor_chai/Controlers/global_method.dart';
import 'package:ghor_chai/screens/general/fetch_screen.dart';
import 'package:ghor_chai/screens/widgets/buttonwidgets.dart';
import 'package:ghor_chai/screens/widgets/custom_widgets.dart';
import 'package:ghor_chai/screens/widgets/dimentions.dart';
import 'package:ghor_chai/screens/widgets/test_widgets.dart';
import 'package:image_picker/image_picker.dart';

import 'package:uuid/uuid.dart';



class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _formKey = GlobalKey<FormState>();
  String _catValue = 'To-Let';

  late final TextEditingController _titleController,
      _priceController,
      _descriptionController,
      _mapUrlController,
      _callController;
  int _groupValue = 1;
  bool isPiece = false;
  File? _pickedImage;

  Uint8List webImage = Uint8List(8);
  @override
  void initState() {
    _priceController = TextEditingController();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();

    //new added part
    _mapUrlController = TextEditingController();
    //_lngController = TextEditingController();
    //new added part

    //new added
    _callController = TextEditingController();
    //new added

    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      _priceController.dispose();
      _titleController.dispose();
      _descriptionController.dispose();

      //new added part
      _mapUrlController.dispose();
      //_lngController.dispose();
      //new added part

      //new added
      _callController.dispose();
      //new added
    }
    super.dispose();
  }

  bool _isLoading = false;
  void _uploadForm() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      if (_pickedImage == null) {
        GlobalMethods.errorDialog(
            subtitle: 'Please pick up an image', context: context);
        return;
      }
      final _uuid = const Uuid().v4();
      try {
        setState(() {
          _isLoading = true;
        });

        final storageRef = FirebaseStorage.instance.ref();
        Reference? imageRef = storageRef.child('productsImages');
        final filename = _uuid + 'jpg';
        final spaceRef = imageRef.child(filename);
        final uploadTask = await spaceRef.putFile(_pickedImage!);
        final imageUri = await uploadTask.ref.getDownloadURL();

        final authEmail = FirebaseAuth.instance.currentUser?.email;

        await FirebaseFirestore.instance.collection('products').doc(_uuid).set({
          'id': _uuid,
          'authEmail': authEmail,
          'title': _titleController.text,
          'description': _descriptionController.text,
          'price': _priceController.text,

          //new added part
          'map': _mapUrlController.text,
          //new added part

          //new added
          'call': _callController.text,
          //new added

          'salePrice': 0.1,
          'imageUrl': imageUri.toString(),
          'productCategoryName': _catValue,
          'isOnSale': false,
          'isPiece': isPiece,
          'createdAt': Timestamp.now(),
        });
        _clearForm();
        Fluttertoast.showToast(
          msg: "Product uploaded Successfully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          // backgroundColor: ,
          // textColor: ,
          // fontSize: 16.0
        );

        //new added
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const FetchScreen()));
        //new added

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

  void _clearForm() {
    isPiece = false;
    _groupValue = 1;
    _priceController.clear();
    _titleController.clear();
    _descriptionController.clear();

    //new added part
    _mapUrlController.clear();
    //_lngController.clear();
    //new added part

    //new added
    _callController.clear();
    //new added

    setState(() {
      _pickedImage = null;
      webImage = Uint8List(8);
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = Utils(context).color;
    Size size = Utils(context).getScreenSize;

    return Scaffold(
      appBar: AppBar(
        title: Text("Post Your Ads"),
        centerTitle: true,
        backgroundColor: Colors.blue.withOpacity(0.2),
      ),


      body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 0,
                    ),
                    Container(
                      width: size.width > 650 ? 650 : size.width,
                      color:
                           Colors.greenAccent.withOpacity(0.2),
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.all(16),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            TextWidget(
                              text: 'House Location*',
                              color: color,
                              isTitle: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Card(
                              margin: EdgeInsets.zero,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(Dimensions.radius)),
                              child: SizedBox(
                                child: TextFormField(
                                  controller: _titleController,
                                  key: const ValueKey('Title'),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a House Location';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Enter a House Location',
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                             CustomColor.primaryColor,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextWidget(
                              text: 'House Description*',
                              color: color,
                              isTitle: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Card(
                              margin: EdgeInsets.zero,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(Dimensions.radius)),
                              child: TextFormField(
                                controller: _descriptionController,
                                maxLines: 5,
                                key: const ValueKey('Description'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a Description';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Enter a Description',
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:  CustomColor.primaryColor,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            //New added part
                            TextWidget(
                              text: 'Map Link',
                              color: color,
                              isTitle: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Card(
                              margin: EdgeInsets.zero,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(Dimensions.radius)),
                              child: TextFormField(
                                controller: _mapUrlController,
                                key: const ValueKey('Map'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a Map link';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Enter map link',
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:  CustomColor.primaryColor,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            //New added part

                            //New added part
                            TextWidget(
                              text: 'Mobile Number',
                              color: color,
                              isTitle: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Card(
                              margin: EdgeInsets.zero,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(Dimensions.radius),
                              ),
                              child: TextFormField(
                                controller: _callController,
                                key: const ValueKey('Call'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please mobile number';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Enter a mobile number',
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:CustomColor.primaryColor,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            //New added part

                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: FittedBox(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                          text: 'Price in \$*',
                                          color: color,
                                          isTitle: true,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          width: 100,
                                          child: Card(
                                            margin: EdgeInsets.zero,
                                            elevation: 5,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  Dimensions.radius),
                                            ),
                                            child: TextFormField(
                                              controller: _priceController,
                                              key: const ValueKey('Price TK'),
                                              keyboardType:
                                              TextInputType.number,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Price is missed';
                                                }
                                                return null;
                                              },
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(r'[0-9.]')),
                                              ],
                                              decoration: InputDecoration(
                                                contentPadding:
                                                const EdgeInsets.only(
                                                  right: 5,
                                                ),
                                                hintText: 'Enter price',
                                                border: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                focusedBorder:
                                                OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color:CustomColor
                                                        .primaryColor,
                                                    width: 1.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        TextWidget(
                                          text: 'House category*',
                                          color: color,
                                          isTitle: true,
                                        ),
                                        const SizedBox(height: 10),
                                        // Drop down menu code here
                                        _categoryDropDown(),

                                        const SizedBox(
                                          height: 20,
                                        ),
                                        TextWidget(
                                          text: 'Measure unit*',
                                          color: color,
                                          isTitle: true,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        // Radio button code here
                                        Row(
                                          children: [
                                            TextWidget(
                                              text: 'Rent',
                                              color: color,
                                              textSize: 18,
                                            ),
                                            Radio(
                                              value: 1,
                                              groupValue: _groupValue,
                                              onChanged: (valuee) {
                                                setState(() {
                                                  _groupValue = 1;
                                                  isPiece = false;
                                                });
                                              },
                                              activeColor: Colors.green,
                                            ),
                                          ],
                                        ),

                                        Row(
                                          children: [
                                            TextWidget(
                                              text: 'Sell',
                                              color: color,
                                              textSize: 18,
                                            ),
                                            Radio(
                                              value: 2,
                                              groupValue: _groupValue,
                                              onChanged: (valuee) {
                                                setState(() {
                                                  _groupValue = 2;
                                                  isPiece = true;
                                                });
                                              },
                                              activeColor: Colors.green,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // Image to be picked code is here
                                Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        height: size.width > 650
                                            ? 350
                                            : size.width * 0.45,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          borderRadius:
                                          BorderRadius.circular(12.0),
                                        ),
                                        child: _pickedImage == null
                                            ? dottedBorder(color: color)
                                            : ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(12),
                                          child: kIsWeb
                                              ? Image.memory(webImage,
                                              fit: BoxFit.fill)
                                              : Image.file(_pickedImage!,
                                              fit: BoxFit.fill),
                                        )),
                                  ),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: FittedBox(
                                      child: Column(
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                _pickedImage = null;
                                                webImage = Uint8List(8);
                                              });
                                            },
                                            child: TextWidget(
                                              text: 'Clear',
                                              color: Colors.red,
                                              textSize: 20,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {},
                                            child: TextWidget(
                                              text: 'Update image',
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  ButtonsWidget(
                                    onPressed: _clearForm,
                                    text: 'Clear form',
                                    icon: IconlyBold.danger,
                                    backgroundColor: Colors.red.shade300,
                                  ),
                                  ButtonsWidget(
                                    onPressed: () {
                                      _uploadForm();
                                    },
                                    text: 'Upload',
                                    icon: IconlyBold.upload,
                                    backgroundColor: Colors.blue,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

    );
  }

  Future<void> _pickImage() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          _pickedImage = selected;
        });
      } else {
        print('No image has been picked');
      }
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          webImage = f;
          _pickedImage = File('a');
        });
      } else {
        print('No image has been picked');
      }
    } else {
      print('Something went wrong');
    }
  }

  Widget dottedBorder({
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DottedBorder(
          dashPattern: const [6.7],
          borderType: BorderType.RRect,
          color: color,
          radius: const Radius.circular(12),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.image_outlined,
                  color: color,
                  size: 50,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                    onPressed: (() {
                      _pickImage();
                    }),
                    child: TextWidget(
                      text: 'Choose an image',
                      color: Colors.blue,
                    ))
              ],
            ),
          )),
    );
  }

  Widget _categoryDropDown() {
    final color = Utils(context).color;
    return Card(
      margin: EdgeInsets.zero,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.radius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
              value: _catValue,
              onChanged: (value) {
                setState(() {
                  _catValue = value!;
                });
                print(_catValue);
              },
              hint: const Text('Select a category'),
              items: const [
                DropdownMenuItem(
                  child: Text(
                    'To-Let',
                  ),
                  value: 'To-Let',
                ),
                DropdownMenuItem(
                  child: Text(
                    'Flat',
                  ),
                  value: 'Flat',
                ),
                DropdownMenuItem(
                  child: Text(
                    'Plot',
                  ),
                  value: 'Plot',
                ),
                DropdownMenuItem(
                  child: Text(
                    'Duplex',
                  ),
                  value: 'Duplex',
                ),
                DropdownMenuItem(
                  child: Text(
                    'Hostel',
                  ),
                  value: 'Hostel',
                ),
                DropdownMenuItem(
                  child: Text(
                    'Hotel',
                  ),
                  value: 'Hotel',
                )
              ],
            )),
      ),
    );
  }
}
