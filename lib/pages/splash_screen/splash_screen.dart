import 'package:minesweeper/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../layouts/main_layout.dart';

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
      Get.offAll(const MainLayout(child: HomePage()));
    });
  }

  Future<void> initApp() async {
    await Future.delayed(const Duration(seconds: 2));
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