import 'dart:io';
import 'package:flutter/material.dart';
import 'package:wmax_devs_task/View/common_widget/custom_text_widget.dart';
import 'package:wmax_devs_task/View/themes/light_theme/app_color.dart';

class CustomProductCartWidget extends StatelessWidget {
  const CustomProductCartWidget({
    super.key,
    required this.image,
    required this.itemName,
    required this.price,
    required this.onTap,
    this.icon,
    this.iconColor,
    required this.onCartTap,
    required this.localImage,
  });

  final String image;
  final String localImage;
  final String itemName;
  final double price;
  final VoidCallback onTap;
  final VoidCallback onCartTap;
  final IconData? icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onCartTap,
      child: Card(
        shape: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              localImage == ''
                  ? Image.network(
                      image.toString(),
                      height: 100,
                      width: 200,
                    )
                  : Image(
                      image: FileImage(File(localImage)),
                      fit: BoxFit.fill,
                      height: 100,
                      width: 200,
                    ),
              CustomTextWidget(
                text: itemName,
                fWeight: FontWeight.w500,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextWidget(
                    text: "\$$price",
                    fWeight: FontWeight.w500,
                  ),
                  InkWell(
                    onTap: onTap,
                    child: Icon(
                      icon ?? Icons.add_shopping_cart,
                      size: size.height / 35,
                      color: iconColor ?? LightThemeData().primaryColor,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}