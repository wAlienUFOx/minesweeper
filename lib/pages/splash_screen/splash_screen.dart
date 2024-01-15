import  'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:minesweeper/core/app_bindings.dart';
import 'package:minesweeper/core/game_service/game_service.dart';
import 'package:minesweeper/core/leaderboard_service/leaderboard_service.dart';
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
    await GetStorage.init();
    Get.find<ThemeService>().initService();
    Get.find<GameService>().initService();
    Get.find<LeaderboardService>().initService();
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Container (
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/splash_img.jpg'),
                fit: BoxFit.cover
            ),
          )
        )
    );
  }
}