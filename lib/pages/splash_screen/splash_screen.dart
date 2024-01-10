import  'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minesweeper/core/app_bindings.dart';
import 'package:minesweeper/core/theme_service/theme_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    initApp().then((value) {
      Get.offAllNamed('/home');
    });
  }

  Future<void> initApp() async {
    await AppBindings().dependencies();
    Get.find<ThemeService>().initService();
    await Future.delayed(const Duration(milliseconds: 100));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Container (
          color: Colors.red,
        )
    );
  }
}