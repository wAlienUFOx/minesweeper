import 'dart:async';

import 'package:flutter/material.dart';
import 'package:minesweeper/widgets/abstract_state.dart';
import 'package:get/get.dart';
import '../../core/game_service/game_service.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends AbstractState<TimerWidget> {
  late GameService gameService;
  late Timer timer;

  @override
  void onInitPage() {
    gameService = Get.find<GameService>();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.onInitPage();
  }

  @override
  void onDispose() {
    timer.cancel();
    super.onDispose();
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
    int seconds = ((gameService.stopwatch.elapsed.inSeconds) + gameService.gameField.savedTimer).toInt();
    String digit = seconds > 999 ? '999' : seconds.toString();

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
