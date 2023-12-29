import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:wmax_devs_task/View/ui/Home/home_screen.dart';
import 'package:wmax_devs_task/global_variable.dart';
import 'View/common_widget/custom_text_widget.dart';
import 'View/ui/Login/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Adjust duration as needed
    );
    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        getUserInfo();
      }
    });
  }

  void getUserInfo() async {
    Box box = Hive.box("user_info");
    userName = await box.get('user_name') ?? '';
    userMail = await box.get('user_mail') ?? '';
    userPhn = await box.get('user_phn') ?? '';
    userPass = await box.get('user_pass') ?? '';
    if(userPhn != '' && userPass != ''){
      Get.offAll(const HomeScreen());
    }else{
      Get.offAll(const LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ScaleTransition(
              scale: _animation,
              child: Image.asset(
                'assets/images/logo.png',
                height: MediaQuery.of(context).size.height / 2,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const CustomTextWidget(
            text: "WEMAX DEV",
            fSize: 30,
            fWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
