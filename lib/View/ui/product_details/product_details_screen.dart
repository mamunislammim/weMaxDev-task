import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wmax_devs_task/Model/Hive_model/cart_product_model.dart';
import 'package:wmax_devs_task/View/common_widget/custom_button.dart';
import 'package:wmax_devs_task/View/common_widget/custom_rating_widget.dart';
import 'package:wmax_devs_task/View/common_widget/custom_text_widget.dart';
import 'package:wmax_devs_task/View/themes/light_theme/app_color.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productListModel});
  final CartListHiveModel productListModel;
  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: size.height / 4,
            width: size.width,
            decoration: BoxDecoration(
                color: const Color(0xffe7bfe4),
                image: DecorationImage(
                  image: FileImage(File(widget.productListModel.localImage))
                  // image: NetworkImage(widget.productListModel.image.toString()),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                  text: widget.productListModel.title,
                  fSize: size.width / 15,
                  fWeight: FontWeight.w500,
                  textAlign: TextAlign.start,
                  maxLines: 2,
                ),
                CustomTextWidget(
                  text: "Price :  \$${widget.productListModel.price}",
                  fSize: size.width / 20,
                  fWeight: FontWeight.w500,
                  textAlign: TextAlign.start,
                ),
                Row(
                  children: [
                    CustomTextWidget(
                      text: "Ratings : ",
                      fSize: size.width / 20,
                      fWeight: FontWeight.w500,
                      textAlign: TextAlign.start,
                    ),
                    _sizedBox(0, 10),
                    const RatingWidget(
                      ratingCount: 3,
                    ),
                  ],
                ),
                CustomTextWidget(
                  text: "Product Details : ",
                  fSize: size.width / 20,
                  fWeight: FontWeight.w500,
                  textAlign: TextAlign.start,
                ),
                CustomTextWidget(
                  text: widget.productListModel.description,
                  fSize: size.width / 25,
                  fWeight: FontWeight.w500,
                  textAlign: TextAlign.start,
                  fColor: LightThemeData().primaryColor.withOpacity(.8),
                  maxLines: 8,
                ),
                _sizedBox(40, 0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButtonWidget(
                      onTap: () {
                        Get.back();
                      },
                      title: "Buy Now",
                      btnWidth: size.width / 2 - 30,
                    ),
                    CustomButtonWidget(
                      onTap: () {
                        Get.back();
                      },
                      title: "Add to Cart",
                      btnWidth: size.width / 2 - 30,
                      btnColor: Colors.orange,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _sizedBox(double height, double width) => SizedBox(
        width: width,
        height: height,
      );
}
