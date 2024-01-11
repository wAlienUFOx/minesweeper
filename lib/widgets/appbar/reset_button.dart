import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minesweeper/core/game_service/game_service.dart';
import 'package:minesweeper/widgets/abstract_state.dart';

class ResetButtonWidget extends StatefulWidget {
  //final void Function() callBack;

  const ResetButtonWidget({
    //required this.callBack,
    super.key
  });

  @override
  State<ResetButtonWidget> createState() => _ResetButtonWidgetState();
}

class _ResetButtonWidgetState extends AbstractState<ResetButtonWidget> {

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Center(
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: Size.zero,
              padding: const EdgeInsets.all(7),
              backgroundColor: theme.colorScheme.onBackground,
              side: BorderSide(color: theme.colorScheme.primary)
          ),
          onPressed: Get.find<GameService>().restartGame,
          child: Icon(Icons.tag_faces_rounded, color: theme.colorScheme.primary)
      ),
    );
  }
}