import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:wmax_devs_task/Controller/apis/all_api_url.dart';
import 'package:wmax_devs_task/Model/product_list_model.dart';
import 'package:wmax_devs_task/View/common_widget/show_snacbar_widget.dart';
import 'package:wmax_devs_task/View/themes/light_theme/app_color.dart';

class ProductListApi {
  Future<List<ProductListModel>> getProductList() async {
    List<ProductListModel> productList = [];
    try {
      Dio dio = Dio();
      var response = await dio.get(Apis().productListUrl);
      if (response.statusCode == 200 ||
          response.statusMessage.toString() == "OK") {
        for (var i in response.data) {
          Rating rating = Rating(
              rate: double.parse(i['rating']['rate'].toString()),
              count: int.parse(i['rating']['count'].toString()));
          ProductListModel productListModel = ProductListModel(
              id: int.parse(i['id'].toString()),
              title: i['title'].toString(),
              description: i['description'].toString(),
              category: i['category'].toString(),
              image: i['image'].toString(),
              price: double.parse(i['price'].toString()),
              rating: rating);
          productList.add(productListModel);
        }
        CustomSnackBar().showSnackBar(title: "Message", message: "Successful");
        return productList;
      }
    } catch (e) {
      debugPrint("Error : $e");
    }
    CustomSnackBar().showSnackBar(
        title: "Message",
        message: "Failed",
        color: LightThemeData().errorColor);
    return productList;
  }
}
