import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minesweeper/core/game_service/game_service.dart';
import 'package:minesweeper/widgets/abstract_state.dart';

class MinesCounterWidget extends StatefulWidget {

  const MinesCounterWidget({super.key});

  @override
  State<MinesCounterWidget> createState() => _MinesCounterWidgetState();
}

class _MinesCounterWidgetState extends AbstractState<MinesCounterWidget> {
  late GameService gameService;
  late int minesCounter;

  @override
  void onInitPage() {
    gameService = Get.find<GameService>();
    minesCounter = gameService.gameField.mines - gameService.flagsCounter.value!;
    gameService.flagsCounter.valueChanges.listen((newValue) {
      minesCounter = gameService.gameField.mines - newValue!;
      if (mounted) setState(() {});
    });
    super.onInitPage();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildDigit(0),
        buildDigit(1),
        buildDigit(2)
      ],
    );
  }

  Widget buildDigit(int index) {
    String digit = minesCounter.toString();
    if (digit.length == 1) {
      if (index < 2) digit = '0';
    } else if (digit.length == 2) {
      if (index == 0) digit = '0';
      if (index == 1) digit = digit.substring(0, 1);
      if (index == 2) digit = digit.substring(1);
    } else {
      if (index == 0) digit = digit.substring(0, 1);
      if (index == 1) digit = digit.substring(1, 2);
      if (index == 2) digit = digit.substring(2, 3);
    }
    return Container(
      width: 30,
      decoration: BoxDecoration(
        color: theme.colorScheme.onBackground,
        border: Border.all(color: theme.colorScheme.primary)
      ),
      child: Center(
          child: Text(
            digit,
            style: TextStyle(color: theme.colorScheme.primary, fontSize: 30),
          )
      ),
    );
  }
}
