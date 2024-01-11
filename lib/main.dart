import 'package:minesweeper/layouts/components/game_appbar.dart';
import 'package:minesweeper/pages/home/home_page.dart';
import 'package:minesweeper/pages/play_screen/play_screen.dart';
import 'package:minesweeper/pages/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minesweeper/themes.dart';
import 'package:minesweeper/widgets/settings_widget.dart';
import 'core/app_bindings.dart';
import 'layouts/components/get_page_of.dart';
import 'layouts/main_layout.dart';

void main() async {

  runApp(const MinesweeperApp());
}

class MinesweeperApp extends StatelessWidget {
  const MinesweeperApp({super.key});

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: 'Minesweeper',
      theme: lightTheme,
      darkTheme: darkTheme,
      initialBinding: AppBindings(),
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPageOf<MainLayout>(
            '/home',
            const HomePage(),
                (page) => MainLayout(bottomButtons: const SettingsWidget(),child: page)
        ),
        GetPageOf<MainLayout>(
            '/game',
            const PlayScreen(),
                (page) => MainLayout(appBar: const GameAppBar(), child: page)
        ),
      ],
    );
  }
}

