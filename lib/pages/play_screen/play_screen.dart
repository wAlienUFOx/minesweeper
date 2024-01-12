import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minesweeper/core/game_service/game_mode.dart';
import 'package:minesweeper/core/game_service/game_service.dart';
import 'package:minesweeper/widgets/abstract_state.dart';
import 'package:minesweeper/widgets/tile_widget.dart';
import '../../core/game_service/tile.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({
    super.key
  });

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends AbstractState<PlayScreen> {

  late GameService gameService;
  late GameMode gameMode;
  late bool resumeGame;
  late void Function() callback;

  double scaleFactor = 1.0;
  double baseScaleFactor = 1.0;

  Future<bool> onPopPage() {
    gameService.stopwatch.stop();
    callback();
    return Future(() => true);
  }

  @override
  void onInitPage() {
    gameService = Get.find<GameService>();
    Map<String, dynamic> args = Get.arguments;
    resumeGame = args['continue'];
    callback = args['callback'];
    if (!resumeGame) {
      gameMode = args['gameMode'];
      gameService.generateEmptyField(gameMode);
    }

    setState(() {});
    gameService.needChangeState.valueChanges.listen((event) {
      if(event! && mounted) setState(() {});
    });
    super.onInitPage();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onPopPage,
      child: GestureDetector(
        onScaleStart: (details) {
          baseScaleFactor = scaleFactor;
        },
        onScaleUpdate: (details) {
          setState(() {
            scaleFactor = baseScaleFactor * details.scale;
            if (scaleFactor < 1.0) scaleFactor = 1.0;
          });
        },
        child: Transform.scale(
          scale: scaleFactor,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: theme.colorScheme.primary)
            ),
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...gameService.gameField.map((column) => buildColumn(column)).toList()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildColumn(List<Tile> column) {
    double x = (MediaQuery.of(context).size.width - 50) / (resumeGame ? gameService.width.toDouble() : gameMode.width);
    double y = (MediaQuery.of(context).size.height - 150) / (resumeGame ? gameService.height.toDouble() : gameMode.height);
    double tileSize = x < y ? x : y;
    return Column(
      children: [
        ...column.map((tile) => TileWidget(tile: tile, size: tileSize)).toList()
      ],
    );
  }
}
