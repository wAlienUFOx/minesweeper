import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minesweeper/core/game_service/tile.dart';
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
  @override
  Widget build(BuildContext context) {
    return Container(
      height:widget.size - 4,
      width: widget.size - 4,
      decoration: BoxDecoration(
        color: Get.isDarkMode ? Colors.white24 : Colors.grey,
        border: Border.all(color: theme.colorScheme.onBackground)
      ),
      margin: const EdgeInsets.all(2),
      child: Center(child: buildChild()),
    );
  }

  Widget buildChild() {
    if (!widget.tile.isOpen) return const SizedBox.shrink();
    if (widget.tile.hasFlag) return const Icon(Icons.flag, color: Colors.red);
    if (widget.tile.hasMine) return const Icon(Icons.local_fire_department, color: Colors.deepOrange);
    Color color = const Color.fromARGB(255, 0, 0, 255);
    if (widget.tile.digit == 2) color = const Color.fromARGB(255, 0, 100, 0);
    if (widget.tile.digit == 3) color = const Color.fromARGB(255, 178, 34, 34);
    if (widget.tile.digit == 4) color = const Color.fromARGB(255, 25, 25, 112);
    if (widget.tile.digit == 5) color = const Color.fromARGB(255, 139, 69, 19);
    if (widget.tile.digit == 6) color = const Color.fromARGB(255, 0, 255, 255);
    if (widget.tile.digit == 7) color = const Color.fromARGB(255, 0, 0, 0);
    if (widget.tile.digit == 8) color = const Color.fromARGB(255, 211, 211, 211);
    return Text(
        widget.tile.digit.toString(),
        style: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.bold));
  }
}
