import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minesweeper/widgets/app_button.dart';

class RulesDialog extends StatelessWidget {

  const RulesDialog({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              color: theme.colorScheme.background,
              borderRadius: const BorderRadius.all(Radius.circular(10.0))
          ),
          margin: const EdgeInsets.symmetric(horizontal: 15),
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Text(
                  'Rules',
                  style: TextStyle(color: theme.colorScheme.onBackground, fontSize: 25),
                ),
                const SizedBox(height: 10),
                Text(
                  'Minesweeper is a game where mines are hidden in a grid of squares. Safe squares have numbers telling you how many mines '
                      'touch the square. You can use the number clues to solve the game by opening all of the safe squares. If you click on '
                      'a mine you lose the game!',
                  style: TextStyle(color: theme.colorScheme.onBackground, fontSize: 18),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 30),
                Text(
                    'Controls',
                    style: TextStyle(color: theme.colorScheme.onBackground, fontSize: 25)
                ),
                const SizedBox(height: 10),
                Text(
                  '- Single click on closed square - open that square\n'
                      '- Double click on closed square - put flag on that square\n'
                      '- Double click / longPress (can be selected in settings) on open square (if number of flags around '
                      'that square is equal to square number) - open safe squares, surrounded clicked one. '
                      'Be Careful! If flags were placed incorrectly - you will lose',
                  style: TextStyle(color: theme.colorScheme.onBackground, fontSize: 18),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AppButton(
                      onPressed: () => Get.back(result: false),
                      title: 'Ok',
                      color: theme.colorScheme.background,
                      fullWidth: false,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}