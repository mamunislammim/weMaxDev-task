import 'package:flutter/material.dart';
import 'package:wmax_devs_task/View/themes/light_theme/app_color.dart';

class CustomSearchWidget extends StatelessWidget {
  const CustomSearchWidget({
    super.key,
    required this.controller,
    this.textInputAction,
    this.tapToToggle,
  });

  final VoidCallback? tapToToggle;
  final TextEditingController controller;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 3, right: 3),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
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
          labelText: "Search here.....",
          labelStyle: const TextStyle(
            color: Colors.black,
          ),
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }
}
