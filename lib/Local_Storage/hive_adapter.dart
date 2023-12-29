import 'package:hive/hive.dart';
import 'package:wmax_devs_task/Model/Hive_model/cart_product_model.dart';

class HiveAdapterClass {
  Future openHiveBox() async {
    await Hive.openBox("user_info");
    await Hive.openBox<CartListHiveModel>("cart_list_product2");
    await Hive.openBox<CartListHiveModel>("product_list1");
  }

  void hiveAdapterBox() {
    Hive.registerAdapter(CartListHiveModelAdapter());
  }
}
