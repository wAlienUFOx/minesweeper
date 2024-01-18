import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minesweeper/core/game_service/game_service.dart';
import 'package:minesweeper/core/settings_service/settings_service.dart';
import 'package:minesweeper/core/tile/tile.dart';
import 'package:minesweeper/widgets/abstract_state.dart';

class TileWidget extends StatefulWidget {
  final Tile tile;
  final double size;
  
  const TileWidget({
    required this.tile,
    required this.size,
    super.key
  });

  @override
  State<TileWidget> createState() => _TileWidgetState();
}

class _TileWidgetState extends AbstractState<TileWidget> {

  late GameService gameService;
  late SettingsService settingsService;

  void openTile () {
    if (!widget.tile.hasFlag) gameService.openTile(widget.tile);
  }

  void changeFLag () {
    gameService.changeFlag(widget.tile);
  }

  void openByFlags () {
    gameService.openByFlags(widget.tile);
  }

  void update () => setState(() {});


  @override
  void onInitPage() {
    gameService = Get.find<GameService>();
    settingsService = Get.find<SettingsService>();
    widget.tile.setCallback(update);
    super.onInitPage();
  }

  @override
  Widget build(BuildContext context) {
    Widget child = IgnorePointer(
      ignoring: widget.tile.ignore,
      child: SizedBox(
        height:widget.size,
        width: widget.size,
        child: Container(
          decoration: BoxDecoration(
              color: Get.isDarkMode ? const Color.fromARGB(255, 50, 50, 50) : Colors.grey,
              border: Border.all(color: theme.colorScheme.onBackground, width: 0.5)
          ),
          margin: EdgeInsets.all(1 * widget.size / 40),
          child: Center(child: buildChild()),
        ),
      ),
    );

    if (widget.tile.isOpen) {
      return GestureDetector(
        onDoubleTap: openByFlags,
        child: child,
      );
    }
    if (settingsService.flagMode == FlagMode.doubleTap) {
      return GestureDetector(
        onTap: openTile,
        onDoubleTap: changeFLag,
        child: child,
      );
    } else {
      return GestureDetector(
        onTap: openTile,
        onLongPress: changeFLag,
        child: child,
      );
    }
  }

  Widget buildChild() {
    double fontSize = 25 * widget.size / 40;
    double iconSize = 25 * widget.size / 40;
    if (!widget.tile.isOpen && widget.tile.hasFlag) {
      return Container(
          width: double.infinity,
          height: double.infinity,
          color: Get.isDarkMode ? const Color.fromARGB(255, 74, 75, 75) : Colors.white24,///
          child: Icon(Icons.flag, color: const Color.fromARGB(255, 165, 42, 42), size: iconSize)
      );
    }
    if (!widget.tile.isOpen) return Container(color: Get.isDarkMode ? const Color.fromARGB(255, 74, 75, 75) : Colors.white24);///
    if (widget.tile.hasMine) {
      return Container(
          width: double.infinity,
          height: double.infinity,
          color: Get.isDarkMode ? const Color.fromARGB(255, 74, 75, 75) : Colors.white24,///
          child: Icon(Icons.local_fire_department, color: Colors.deepOrange, size: iconSize)
    );
    }
    Color color = const Color.fromARGB(255, 0, 0, 255);
    if (widget.tile.digit == 0) return Container(color: Get.isDarkMode ? const Color.fromARGB(255, 50, 50, 50) : Colors.grey);
    if (widget.tile.digit == 2) color = const Color.fromARGB(255, 0, 100, 0);
    if (widget.tile.digit == 3) color = const Color.fromARGB(255, 178, 34, 34);
    if (widget.tile.digit == 4) color = const Color.fromARGB(255, 25, 25, 112);
    if (widget.tile.digit == 5) color = const Color.fromARGB(255, 139, 69, 19);
    if (widget.tile.digit == 6) color = const Color.fromARGB(255, 0, 255, 255);
    if (widget.tile.digit == 7) color = const Color.fromARGB(255, 0, 0, 0);
    if (widget.tile.digit == 8) color = const Color.fromARGB(255, 211, 211, 211);
    return Text(
        widget.tile.digit.toString(),
        style: TextStyle(color: color, fontSize: fontSize, fontWeight: FontWeight.bold));
  }
}
