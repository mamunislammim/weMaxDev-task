import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:wmax_devs_task/Controller/repository/product_list_repo.dart';
import 'package:wmax_devs_task/Controller/service/image_downloader.dart';
import 'package:wmax_devs_task/Controller/service/internet_connection_checker.dart';
import 'package:wmax_devs_task/Model/Hive_model/cart_product_model.dart';
import 'package:wmax_devs_task/View/common_widget/show_snacbar_widget.dart';

class ProductListController extends GetxController {
  Box box = Hive.box<CartListHiveModel>("product_list1");
  var productLists = [].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getAndSetProductFromApi();
  }

  void getAndSetProductFromApi()async{
    try{
      if(await ConnectionChecker().checkConnection() == false){
        productLists = box.values.toList().obs;
        await CustomSnackBar().internetChecker();
        return;
      }
      isLoading(true);
      var receivedData = await ProductListApi().getProductList();
      await box.clear();
      productLists.clear();
      for(var i in receivedData.toList()){
       String imgPath = await DownloadImage().saveNetworkImage(url: i.image.toString(),id: i.id?? 0);
        CartListHiveModel model = CartListHiveModel(
            id: i.id ?? 0,
            title: i.title.toString(),
            price: i.price ?? 0,
            image: i.image.toString(),
            category: i.category.toString(),
            description: i.description.toString(),
            localImage: imgPath);
       await box.add(model);

      }
      productLists = box.values.toList().obs;
    }finally{
      isLoading(false);
    }
  }
}