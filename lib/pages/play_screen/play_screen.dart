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
  int width = 10;
  int height = 20;
  int mines = 45;
  late GameService gameService;

  @override
  void onInitPage() {
    gameService = Get.find<GameService>();
    gameService.generateEmptyField(width, height);
    gameService.generateField(width, height, mines, 5, 15);
    setState(() {});
    super.onInitPage();
  }

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...gameService.gameField.map((column) => buildColumn(column)).toList()
      ],
    );
  }

  Widget buildColumn(List<Tile> column) {
    double x = MediaQuery.of(context).size.width / width;
    double y = MediaQuery.of(context).size.height / height;
    double tileSize = x < y ? x : y;
    return Column(
      children: [
        ...column.map((tile) => TileWidget(tile: tile, size: tileSize)).toList()
      ],
    );
  }
}
