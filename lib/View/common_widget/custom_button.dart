import 'package:flutter/material.dart';
import 'package:wmax_devs_task/View/themes/light_theme/app_color.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget(
      {super.key,
      required this.onTap,
      required this.title,
      this.btnColor,
      this.btnHeight,
      this.btnWidth});

  final VoidCallback onTap;
  final String title;
  final Color? btnColor;
  final double? btnHeight;
  final double? btnWidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: btnColor ?? LightThemeData().primaryColor,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        child: SizedBox(
          height: btnHeight ?? 45,
          width: btnWidth,
          child: Center(
            child: Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
