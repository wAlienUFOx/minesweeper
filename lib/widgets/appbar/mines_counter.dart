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
    minesCounter = gameService.mines;
    gameService.flagsCounter.valueChanges.listen((newValue) {
      minesCounter = gameService.mines - newValue!;
      setState(() {});
    });
    super.onInitPage();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildDigit(true),
        buildDigit(false)
      ],
    );
  }

  Widget buildDigit(bool isFirst) {
    String digit = minesCounter.toString();
    
    if (digit.length == 1) {
      if (isFirst) digit = '0';
    } else {
      if (isFirst) {
        digit = digit.substring(0, 1);
      } else {
        digit = digit.substring(1);
      } 
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
