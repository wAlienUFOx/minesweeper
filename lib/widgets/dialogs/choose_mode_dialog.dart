import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minesweeper/core/game_mode/game_mode.dart';
import 'package:minesweeper/core/local_storage/local_storage.dart';
import 'package:minesweeper/widgets/abstract_state.dart';
import '../app_button.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ChooseModeDialog extends StatefulWidget {
  const ChooseModeDialog({super.key});

  @override
  State<ChooseModeDialog> createState() => _ChooseModeDialogState();
}

class _ChooseModeDialogState extends AbstractState<ChooseModeDialog> {

  late FormControl<String> customWidth;
  late FormControl<String> customHeight;
  late FormControl<String> customMines;

  bool customAvailable() {
    if (customWidth.value!.isEmpty) return false;
    if (customHeight.value!.isEmpty) return false;
    if (customMines.value!.isEmpty) return false;
    if (int.parse(customWidth.value!) > 20 || int.parse(customWidth.value!) < 5) return false;
    if (int.parse(customHeight.value!) > 50 || int.parse(customHeight.value!) < 5) return false;
    int width = int.parse(customWidth.value!);
    int height = int.parse(customHeight.value!);
    int mines = int.parse(customMines.value!);
    if (height == 0 || width == 0 || mines == 0) return false;
    if (mines > height * width) return false;
    if (mines > 99) return false;
    return true;
  }

  @override
  void onInitPage() {
    GameMode customGameMode;
    if (LocalStorage.customMode != null) {
      customGameMode = GameMode.fromJson(LocalStorage.customMode!);
    } else {
      customGameMode = GameMode(width: 10, height: 20, mines: 40);
    }
    customWidth = FormControl(value: customGameMode.width.toString());
    customHeight = FormControl(value: customGameMode.height.toString());
    customMines = FormControl(value: customGameMode.mines.toString());
    super.onInitPage();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              color: theme.colorScheme.background,
              borderRadius: const BorderRadius.all(Radius.circular(10.0))
          ),
          margin: const EdgeInsets.symmetric(horizontal: 15),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Column(
            mainAxisSize: MediaQuery.of(context).viewInsets.bottom == 0 ? MainAxisSize.min : MainAxisSize.max,
            children: [
              const SizedBox(height: 10),
              Text(
                  'New game',
                  style: TextStyle(color: theme.colorScheme.primary, fontSize: 25)
              ),
              const SizedBox(height: 30),
              AppButton(
                onPressed: () => Get.back(result: GameMode(width: 9, height: 9, mines: 10)),
                title: 'Beginner',
                color: theme.colorScheme.background,
                fullWidth: true,
              ),
              const SizedBox(height: 10),
              AppButton(
                onPressed: () => Get.back(result: GameMode(width: 16, height: 16, mines: 40)),
                title: 'Medium',
                color: theme.colorScheme.background,
                fullWidth: true,
              ),
              const SizedBox(height: 10),
              AppButton(
                onPressed: () => Get.back(result: GameMode(width: 16, height: 30, mines: 99)),
                title: 'Expert',
                color: theme.colorScheme.background,
                fullWidth: true,
              ),
              const SizedBox(height: 10),
              IgnorePointer(
                ignoring: !customAvailable(),
                child: AppButton(
                  onPressed: () {
                    GameMode gameMode = GameMode(
                        width: int.parse(customWidth.value!),
                        height: int.parse(customHeight.value!),
                        mines: int.parse(customMines.value!)
                    );
                    LocalStorage.customMode = gameMode.toJson();
                    Get.back(result: gameMode);
                  },
                  title: 'Custom',
                  color: theme.colorScheme.background.withOpacity(customAvailable() ? 1.0 : 0.3),
                  fullWidth: true,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildCustomChoose('Width', customWidth),
                  buildCustomChoose('Height', customHeight),
                  buildCustomChoose('Mines', customMines),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCustomChoose (String title, FormControl<String> formControl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: TextStyle(color: theme.colorScheme.primary, fontSize: 20)),
        const SizedBox(height: 10),
        SizedBox(
            width: 60,
            child: ReactiveTextField(
              formControl: formControl,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                filled: true,
                fillColor: theme.colorScheme.onBackground,
                border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 7)
              ),
              style: TextStyle(
                fontSize: 20,
                color: theme.colorScheme.primary,
              ),
              inputFormatters: [MaskTextInputFormatter(
                      mask: '###',
                      filter: { "#": RegExp(r'[0-9]') },
                      type: MaskAutoCompletionType.lazy
                  )],
            )
        )
      ],
    );
  }
}
