import 'package:flutter/material.dart';
import 'package:minesweeper/widgets/appbar/mines_counter.dart';
import 'package:minesweeper/widgets/appbar/reset_button.dart';
import 'package:minesweeper/widgets/appbar/timer.dart';
import '../../widgets/abstract_state.dart';

class GameAppBar extends StatefulWidget {
  const GameAppBar({super.key});

  @override
  State<GameAppBar> createState() => _GameAppBarState();
}

class _GameAppBarState extends AbstractState<GameAppBar> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
      ),
      padding: const EdgeInsets.all(7.0),
      child:  const Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MinesCounterWidget(),
              TimerWidget()
            ],
          ),
          ResetButtonWidget(),
        ]
      ),
    );
  }
}
