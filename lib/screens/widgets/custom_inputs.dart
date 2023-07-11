import 'package:flutter/material.dart';
import 'package:ghor_chai/Controlers/custom_colors.dart';
import 'package:ghor_chai/screens/widgets/custom_styles.dart';

//import 'package:ghor_chai/screens/widgets/size.dart';
import 'package:ghor_chai/screens/widgets/text_lebel_widgets.dart';




class CustomInputWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final bool? hintClrPrimary;
  final bool? isBottomHeight;
  final Color? color;
  final double focusedBorderWidth;
  final double enabledBorderWidth;
  final Color borderColor;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final String labelText;
  final Function(String)? onChanged;
  final FocusNode? focusNode;

  const CustomInputWidget({
    Key? key,
    this.controller,
    this.focusNode,
    this.onChanged,
    required this.hintText,
    this.keyboardType,
    this.readOnly = false,
    this.isBottomHeight = true,
    this.focusedBorderWidth = 2,
    this.enabledBorderWidth = 2,
    this.color = CustomColor.fillColor,
    this.borderColor = CustomColor.borderColor,
    this.hintClrPrimary = false,
    this.suffixIcon,
    this.onTap,
    required this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    //bool isDark = Utils(context).getTheme;
    return Column(
      children: [
        CustomLabelWidget(
          text: labelText,
        ),
        SizedBox(
          height: 63,
          width: double.infinity,
          child: TextFormField(
            onChanged: onChanged,
            focusNode: focusNode,
            style: TextStyle(
              color: CustomColor.primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            readOnly: readOnly!,
            controller: controller,
            keyboardType: keyboardType,
            onTap: onTap,
            validator: (String? value) {
              if (value!.isEmpty) {
                return null;
              } else {
                return 'Please Fill Out The Field';
              }
            },
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                      color: borderColor.withOpacity(0.40),
                      width: enabledBorderWidth),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide:
                      BorderSide(color: borderColor, width: focusedBorderWidth),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.red, width: 1),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.red, width: 1),
                ),
                // filled: true,
                // fillColor: color,
                contentPadding: const EdgeInsets.only(
                    left: 10, right: 0, top: 14, bottom: 10),
                hintText: hintText,
                hintStyle: 
                     TextStyle(
                        color: CustomColor.primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      )
                    
          ),
        ),
        )
      ],
    );
  }
}