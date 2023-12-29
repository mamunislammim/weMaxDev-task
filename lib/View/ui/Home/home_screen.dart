import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:wmax_devs_task/Model/Hive_model/cart_product_model.dart';
import 'package:wmax_devs_task/View/common_widget/custom_search_field.dart';
import 'package:wmax_devs_task/View/common_widget/custom_text_widget.dart';
import 'package:wmax_devs_task/View/common_widget/product_cart_widget.dart';
import 'package:wmax_devs_task/View/common_widget/show_snacbar_widget.dart';
import 'package:wmax_devs_task/View/themes/light_theme/app_color.dart';
import 'package:wmax_devs_task/View/ui/Add_New_Product/add_new_product.dart';
import 'package:wmax_devs_task/View/ui/Cart/Controller/cart_controller.dart';
import 'package:wmax_devs_task/View/ui/Cart/cart_screen.dart';
import 'package:wmax_devs_task/View/ui/Home/controller/product_list.dart';
import 'package:wmax_devs_task/View/ui/User_profile/user_profile_screen.dart';
import 'package:wmax_devs_task/View/ui/product_details/product_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  ProductListController productListController =
      Get.put(ProductListController());
  CartController cartController = Get.put(CartController());

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => productListController.isLoading.value
          ? const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Scaffold(
              appBar: AppBar(
                title: const Text("WeMax Shop"),
                actions: [
                  IconButton(
                    onPressed: () {
                      Get.to(const ProductCartScreen());
                    },
                    icon: Badge(
                      label: Text(cartController.cartList.length.toString()),
                      child: const Icon(
                        Icons.add_shopping_cart,
                        size: 25,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.to(const UserProfileScreen());
                    },
                    icon: const Icon(
                      Icons.person,
                      size: 25,
                    ),
                  ),
                ],
              ),
              body: productListController.productLists.isNotEmpty
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              CustomSearchWidget(controller: _searchController),
                        ),
                        Expanded(
                          child: GetBuilder<ProductListController>(
                            builder: (controller) {
                              return GridView.builder(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                itemCount: controller.productLists.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                itemBuilder: (_, index) {
                                  CartListHiveModel data =
                                      controller.productLists[index];
                                  return CustomProductCartWidget(
                                    image: data.image.toString(),
                                    itemName: data.title.toString(),
                                    price: data.price,
                                    onTap: () async {
                                    await addToCartFunction(data: data);
                                    CustomSnackBar().showSnackBar(title: "Message", message: "Add to cart !!",);
                                    },
                                    localImage: data.localImage,
                                    onCartTap: () {
                                      Get.to(ProductDetailsScreen(
                                        productListModel: data,
                                      ));
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                productListController.getAndSetProductFromApi();
                              },
                              icon: const Icon(
                                Icons.restart_alt,
                                size: 50,
                              )),
                          const CustomTextWidget(
                            text: "Empty Shop",
                          ),
                        ],
                      ),
                    ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: LightThemeData().primaryColor,
                onPressed: () {
                  Get.to(const NewProductAddScreen());
                },
                child: Icon(
                  Icons.add,
                  color: LightThemeData().secondaryColor,
                ),
              ),
            ),
    );
  }

  Future addToCartFunction({required CartListHiveModel data})async{
    Box box = Hive.box<CartListHiveModel>(
        "cart_list_product2");
    CartListHiveModel model =
    CartListHiveModel(
        id: data.id,
        title: data.title.toString(),
        price: data.price,
        image: data.image.toString(),
        category:
        data.category.toString(),
        description:
        data.description.toString(),
        localImage: data.localImage);
    await box.add(model);
    cartController.cartList.add(model);
  }
}
