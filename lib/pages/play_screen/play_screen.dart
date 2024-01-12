import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  int width = 5;
  int height = 10;
  int mines = 3;
  late GameService gameService;

  double scaleFactor = 1.0;
  double baseScaleFactor = 1.0;


  @override
  void onInitPage() {
    gameService = Get.find<GameService>();
    gameService.generateEmptyField(width, height, mines);
    setState(() {});
    gameService.needChangeState.valueChanges.listen((event) {
      if(event! && mounted) setState(() {});
    });
    super.onInitPage();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
    );
  }

  Widget buildColumn(List<Tile> column) {
    double x = MediaQuery.of(context).size.width / width;
    double y = (MediaQuery.of(context).size.height - 150) / height;
    double tileSize = x < y ? x : y;
    return Column(
      children: [
        ...column.map((tile) => TileWidget(tile: tile, size: tileSize)).toList()
      ],
    );
  }
}
