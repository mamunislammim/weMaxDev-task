import 'package:flutter/material.dart';
import 'package:wmax_devs_task/View/themes/light_theme/app_color.dart';

class CustomTextFieldWidget extends StatelessWidget {
  const CustomTextFieldWidget({
    super.key,
    required this.text,
    required this.controller,
    this.textInputAction, this.textInputType, this.maxLine,
  });
  final String text;
  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final int? maxLine;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 3, right: 3),
      child: TextFormField(
        maxLines: maxLine ?? 1,
        controller: controller,
        keyboardType: textInputType ?? TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        style: TextStyle(color: LightThemeData().primaryColor),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red.withOpacity(.5)),
              borderRadius: BorderRadius.circular(30)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: LightThemeData().primaryColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: LightThemeData().primaryColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: LightThemeData().primaryColor)),
          labelText: text.toString(),
          labelStyle: TextStyle(
            color: Colors.black.withOpacity(.5),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter $text';
          }
          return null;
        },
      ),
    );
  }
}
