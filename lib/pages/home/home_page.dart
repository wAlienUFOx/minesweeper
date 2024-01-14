import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minesweeper/core/game_service/game_service.dart';
import 'package:minesweeper/widgets/abstract_state.dart';
import 'package:minesweeper/widgets/app_button.dart';
import 'package:minesweeper/widgets/dialogs/choose_mode_dialog.dart';
import '../../widgets/group_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends AbstractState<HomePage> {

  late GameService gameService;

  void onGoBack() => setState(() {});

  @override
  void onInitPage() {
    gameService = Get.find<GameService>();
    setState(() {});
    super.onInitPage();
  }

  @override
  Widget build(BuildContext context) {

    List<GroupButton> menuItems = [
      if (gameService.canContinue()) GroupButton(
          title: 'Continue',
          onTap: () => Get.toNamed('/game', arguments: {
            'continue' : true,
            'callback' : onGoBack
          })
      ),
      GroupButton(
          title: 'New game',
          onTap: () => Get.dialog(const ChooseModeDialog()).then((gameMode) {
            if (gameMode != null) {
              Get.toNamed('/game', arguments: {
                'continue' : false,
                'gameMode': gameMode,
                'callback' : onGoBack
            });
            }
          })
      ),
      GroupButton(
          title: 'Leaderboard',
          onTap: () => {}
      ),
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: menuItems.map<Widget>((item) => buildMenuItem(item)).toList()
      ),
    );
  }

  Widget buildMenuItem(GroupButton item) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: AppButton(
          onPressed: item.onTap,
          title: item.title,
          color: theme.colorScheme.primary
      ),
    );
  }
}