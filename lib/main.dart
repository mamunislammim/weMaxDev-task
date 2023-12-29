import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:wmax_devs_task/Local_Storage/hive_adapter.dart';
import 'package:wmax_devs_task/View/themes/light_theme/app_color.dart';
import 'package:wmax_devs_task/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  HiveAdapterClass().hiveAdapterBox();
  await HiveAdapterClass().openHiveBox();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: LightThemeData().primaryColor,
          titleTextStyle: TextStyle(
              color: LightThemeData().textLightColor,
              fontSize: 23,
              fontWeight: FontWeight.w500),
          centerTitle: true,
          iconTheme: IconThemeData(
            color: LightThemeData().secondaryColor,
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
