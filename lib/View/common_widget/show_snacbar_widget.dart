import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wmax_devs_task/View/themes/light_theme/app_color.dart';

class CustomSnackBar {
  Future showSnackBar(
      {required String title, required String message, Color? color}) async {
    Get.snackbar(
      title,
      message,
      colorText: LightThemeData().secondaryColor,
      backgroundColor: color ?? LightThemeData().snacbarColor,
      icon: Icon(
        Icons.add_alert,
        color: LightThemeData().primaryColor,
        size: 30,
      ),
    );
  }

  Future internetChecker() async {
    Get.snackbar(
      "No Internet.!!",
      "Please Check Internet Connection..!!",
      colorText: LightThemeData().secondaryColor,
      backgroundColor: LightThemeData().errorColor,
      icon: Icon(
        Icons.add_alert,
        color: LightThemeData().primaryColor,
      ),
    );
  }
}
