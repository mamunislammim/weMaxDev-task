import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wmax_devs_task/View/common_widget/custom_button.dart';
import 'package:wmax_devs_task/View/common_widget/custom_text_widget.dart';
import 'package:wmax_devs_task/View/common_widget/product_cart_widget.dart';
import 'package:wmax_devs_task/View/common_widget/show_snacbar_widget.dart';
import 'package:wmax_devs_task/View/ui/Cart/Controller/cart_controller.dart';
import 'package:wmax_devs_task/View/ui/Home/home_screen.dart';
import 'package:wmax_devs_task/View/ui/product_details/product_details_screen.dart';

class ProductCartScreen extends StatefulWidget {
  const ProductCartScreen({super.key});

  @override
  State<ProductCartScreen> createState() => _ProductCartScreenState();
}

class _ProductCartScreenState extends State<ProductCartScreen> {
  final TextEditingController _searchController = TextEditingController();
  CartController cartController = Get.put(CartController());

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => cartController.isLoading.value
          ? const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Scaffold(
              appBar: AppBar(
                title:  const Text("Cart "),
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
                ],
              ),
              body: cartController.cartList.isNotEmpty
                  ? GridView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      itemCount: cartController.cartList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (_, index) {
                        return CustomProductCartWidget(
                          localImage: cartController.cartList[index].localImage,
                          image: cartController.cartList[index].image,
                          itemName: cartController.cartList[index].title,
                          price: cartController.cartList[index].price,
                          onTap: () {
                           cartController.deleteCartProduct(index: index);
                            cartController.cartList.removeAt(index);
                           CustomSnackBar().showSnackBar(title: "Message", message: "Delete cart item !!",);
                           if(cartController.cartList.isEmpty){
                              cartController.isLoading =false.obs;
                            }
                          },
                          icon: Icons.delete_forever,
                          iconColor: Colors.red,
                          onCartTap: (){
                            Get.to(ProductDetailsScreen(productListModel: cartController.cartList[index]));
                          },
                        );
                      },
                    )
                  : const Center(
                      child: CustomTextWidget(text: "Empty Cart"),
                    ),
              bottomNavigationBar: cartController.cartList.isNotEmpty
                  ? CustomButtonWidget(
                      title: "Buy Now",
                      onTap: () {
                        Get.offAll(const HomeScreen());
                      },
                      btnColor: Colors.orange,
                    )
                  : const SizedBox(),
            ),
    );
  }
}
