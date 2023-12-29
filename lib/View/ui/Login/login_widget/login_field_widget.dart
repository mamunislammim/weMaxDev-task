import 'package:flutter/material.dart';
import 'package:wmax_devs_task/View/themes/light_theme/app_color.dart';

class LoginFieldWidget extends StatelessWidget {
  const LoginFieldWidget({
    super.key,
    required this.text,
    required this.controller,
    required this.obsSecureText,
    this.password,
    this.textInputAction,
    required this.prefixIcon,
    this.tapToToggle,
  });

  final VoidCallback? tapToToggle;
  final String text;
  final TextEditingController controller;
  final bool obsSecureText;
  final bool? password;
  final TextInputAction? textInputAction;
  final Icon prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 3, right: 3),
      child: TextFormField(
        obscureText: obsSecureText,
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
            labelText: text.toString(),
            labelStyle: const TextStyle(
              color: Colors.black,
            ),
            prefixIcon: prefixIcon,
            suffixIcon: password != null
                ? obsSecureText == true
                    ? IconButton(
                        onPressed: tapToToggle,
                        icon: Icon(
                          Icons.visibility,
                          size: 20,
                          color: LightThemeData().primaryColor,
                        ),
                      )
                    : IconButton(
                        onPressed: tapToToggle,
                        icon: Icon(
                          Icons.visibility_off,
                          size: 20,
                          color: LightThemeData().primaryColor,
                        ),
                      )
                : null),
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
