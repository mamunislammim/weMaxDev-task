import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hive/hive.dart';
import 'package:wmax_devs_task/Model/Hive_model/cart_product_model.dart';
import 'package:wmax_devs_task/View/ui/Cart/Controller/cart_controller.dart';
import 'package:wmax_devs_task/View/ui/Home/controller/product_list.dart';
import 'package:wmax_devs_task/View/ui/Login/login_page.dart';
import 'package:wmax_devs_task/View/ui/User_profile/profile_widget/user_profile_widget.dart';
import 'package:wmax_devs_task/global_variable.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {

  Future clearDataForLogOut()async{
    Box userBox = Hive.box("user_info");
    Box productBox = Hive.box<CartListHiveModel>("product_list1");
    Box cartBox = Hive.box<CartListHiveModel>("cart_list_product2");
    await userBox.clear();
    await productBox.clear();
    await cartBox.clear();
    CartController().cartList.clear();
    ProductListController().productLists.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        actions: [
          IconButton(
              onPressed: () async {
                await clearDataForLogOut();
                Get.offAll(const LoginScreen());
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          _sizedBox(10, 0),
          const CircleAvatar(
            radius: 60,
            child: Center(
                child: Icon(
              Icons.person,
              size: 50,
            )),
          ),
          _sizedBox(10, 0),
          UserInformationWidget(
            title: 'Name :',
            titleData: userName.toString(),
          ),
          UserInformationWidget(
            title: 'Email :',
            titleData: userMail.toString(),
          ),
          UserInformationWidget(
            title: 'Phone :',
            titleData: userPhn.toString(),
          ),
          UserInformationWidget(
            title: 'Pass :',
            titleData: userPass.toString(),
          ),
        ],
      ),
    );
  }

  SizedBox _sizedBox(double height, double width) => SizedBox(
        height: height,
        width: width,
      );
}
