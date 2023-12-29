import 'package:flutter/material.dart';
import 'package:wmax_devs_task/View/themes/light_theme/app_color.dart';

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget(
      {Key? key,
      required this.text,
      this.fSize,
      this.fWeight,
      this.fColor,
      this.textAlign,
      this.maxLines,
      this.overflow,
      this.bgColor})
      : super(key: key);
  final String? text;
  final double? fSize;
  final FontWeight? fWeight;
  final Color? fColor;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toString(),
      style: TextStyle(
          color: fColor ?? LightThemeData().primaryColor,
          fontSize: fSize ?? 15,
          fontWeight: fWeight ?? FontWeight.normal,
          backgroundColor: bgColor ?? Colors.transparent),
      textAlign: textAlign ?? TextAlign.center,
      maxLines: maxLines ?? 1,
      overflow: overflow ?? TextOverflow.ellipsis,
    );
  }
}
