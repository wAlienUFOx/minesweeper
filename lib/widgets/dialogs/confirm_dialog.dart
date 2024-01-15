import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minesweeper/widgets/app_button.dart';

class ConfirmDialog extends StatelessWidget {
  final String event;

  const ConfirmDialog({
    required this.event,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  'Are you sure you want to $event?',
                  style: TextStyle(color: theme.colorScheme.onBackground, fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AppButton(
                    onPressed: () => Get.back(result: false),
                    title: 'No',
                    color: theme.colorScheme.background,
                    fullWidth: false,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  ),
                  AppButton(
                    onPressed: () => Get.back(result: true),
                    title: 'Yes',
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