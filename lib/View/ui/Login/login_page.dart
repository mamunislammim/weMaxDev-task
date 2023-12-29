import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:wmax_devs_task/Controller/service/internet_connection_checker.dart';
import 'package:wmax_devs_task/View/common_widget/custom_button.dart';
import 'package:wmax_devs_task/View/common_widget/custom_text_widget.dart';
import 'package:wmax_devs_task/View/common_widget/show_snacbar_widget.dart';
import 'package:wmax_devs_task/View/themes/light_theme/app_color.dart';
import 'package:wmax_devs_task/View/ui/Home/home_screen.dart';
import 'package:wmax_devs_task/global_variable.dart';
import 'login_widget/login_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  var isEnable = true.obs;


  Future setUserInfo({required String name,required String phn,required String mail,required String pass,})async{
    Box box = Hive.box("user_info");
    await box.put('user_name' , name);
    await box.put('user_mail' , mail);
    await box.put('user_phn' , phn);
    await box.put('user_pass' , pass);
    userName = name;
    userPhn =phn;
    userPass = pass;
    userMail = mail;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _mailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// =========================== Header Logo =======================
                Image.asset('assets/images/logo.png'),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _sizedBox(size.height / 30),
                      Padding(
                        padding: EdgeInsets.only(top: size.height / 50),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                const CustomTextWidget(
                                  text: "WEMAX DEV",
                                  fSize: 30,
                                  fWeight: FontWeight.w600,
                                ),
                                _sizedBox(size.height / 30),

                                /// =========================== User ID =======================
                                LoginFieldWidget(
                                  text: 'Email',
                                  controller: _mailController,
                                  prefixIcon: Icon(
                                    Icons.mail_outline_outlined,
                                    color: LightThemeData().primaryColor,
                                  ),
                                  obsSecureText: false,
                                ),
                                _sizedBox(size.height / 50),

                                /// ===========================  Password =======================
                                Obx(() => LoginFieldWidget(
                                  text: 'Password',
                                  controller: _passwordController,
                                  password: true,
                                  obsSecureText: isEnable.value,
                                  prefixIcon: Icon(
                                    Icons.security,
                                    color: LightThemeData().primaryColor,
                                  ),
                                  tapToToggle: () {
                                    isEnable.value = !isEnable.value;
                                  },
                                ),),
                                _sizedBox(size.height / 30),

                                /// ===========================  Login  =======================
                                CustomButtonWidget(onTap: () async{
                                  FocusManager.instance.primaryFocus!.unfocus();
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  if(await ConnectionChecker().checkConnection() == false){
                                    return CustomSnackBar().internetChecker();
                                  }
                                  setUserInfo(name: 'Md Mamun Islam', phn: '01761810531', mail: _mailController.text, pass: _passwordController.text);
                                 await CustomSnackBar().showSnackBar(title: "Message", message: "Login Successful");
                                 Get.offAll(const HomeScreen());
                                }, title: "Login")
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _sizedBox(double height) {
    return SizedBox(height: height,);
  }
}
