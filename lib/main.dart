import 'package:edu_meneger_techer_08_09_2024/screen/home_page.dart';
import 'package:edu_meneger_techer_08_09_2024/screen/login/login_page.dart';
import 'package:edu_meneger_techer_08_09_2024/screen/splash/splash_page.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async{
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Edu Meneger',
      home: SplashPage(),
    );
  }
}
