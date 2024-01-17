import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minesweeper/core/game_service/game_mode/game_mode.dart';
import 'package:minesweeper/core/game_service/game_service.dart';
import 'package:minesweeper/widgets/abstract_state.dart';
import 'package:minesweeper/widgets/tile_widget.dart';
import '../../core/tile/tile.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({
    super.key
  });

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends AbstractState<PlayScreen> with WidgetsBindingObserver {
  late GameService gameService;
  late GameMode gameMode;
  late bool resumeGame;
  late void Function() callback;

  void onPopPage(bool success) {
    if(success) {
      gameService.pauseTimer();
      gameService.saveField();
      callback();
    }
  }

  void updateState() => setState(() {});

  @override
  void onInitPage() {
    WidgetsBinding.instance.addObserver(this);
    gameService = Get.find<GameService>();
    gameService.callback = updateState;

    Map<String, dynamic> args = Get.arguments;
    resumeGame = args['continue'];
    callback = args['callback'];
    if (!resumeGame) {
      gameMode = args['gameMode'];
      gameService.generateEmptyField(gameMode, false);
    }

    setState(() {});
    super.onInitPage();
  }

  @override
  void onDispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onDispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) gameService.startTimer();
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      gameService.pauseTimer();
      gameService.saveField();
    }
    if (state == AppLifecycleState.detached) gameService.saveField();
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (success) => onPopPage(success),
      child: InteractiveViewer(
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: theme.colorScheme.primary)
            ),
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...gameService.gameField.field.map((column) => buildColumn(column)).toList()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildColumn(List<Tile> column) {
    double x = (MediaQuery.of(context).size.width - 42) / (resumeGame ? gameService.gameField.width.toDouble() : gameMode.width);
    double y = (MediaQuery.of(context).size.height - 40 - 55 - 55 - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom) / (resumeGame ? gameService.gameField.height.toDouble() : gameMode.height);
    double tileSize = x < y ? x : y;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...column.map((tile) => TileWidget(tile: tile, size: tileSize)).toList()
      ],
    );
  }
}
