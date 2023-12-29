
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:wmax_devs_task/Model/Hive_model/cart_product_model.dart';

class CartController extends GetxController{
  Box<CartListHiveModel> box = Hive.box<CartListHiveModel>("cart_list_product2");
  var cartList = [].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getCartProduct();
  }

  void getCartProduct() async {
    isLoading(true);
    cartList = box.values.toList().obs;
    isLoading(false);
  }

  void deleteCartProduct({required int index})async{
   await box.deleteAt(index);
  }
}