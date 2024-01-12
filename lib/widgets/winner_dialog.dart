import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minesweeper/widgets/app_button.dart';

class WinnerDialog extends StatelessWidget {
  final int time;

  const WinnerDialog({
    required this.time,
    super.key
  });

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Text(
                  'Winner winner chicken dinner!',
                  style: TextStyle(color: theme.colorScheme.primary, fontSize: 25)
              ),
              const SizedBox(height: 30),
              Text(
                  'Your time is: $time',
                  style: TextStyle(color: theme.colorScheme.primary, fontSize: 20)
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AppButton(
                    onPressed: () => Get.back(result: true),
                    title: 'New game',
                    color: theme.colorScheme.background,
                    fullWidth: false,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  ),
                  AppButton(
                    onPressed: () => Get.back(result: false),
                    title: 'Ok',
                    color: theme.colorScheme.background,
                    fullWidth: false,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// Widget buildButton (String title, void Function() onTap) {
//   return
// }