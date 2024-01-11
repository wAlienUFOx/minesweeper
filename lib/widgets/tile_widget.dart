import 'package:flutter/material.dart';
import 'package:minesweeper/core/game_service/tile.dart';

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

class _TileWidgetState extends State<TileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height:widget.size - 4,
      width: widget.size - 4,
      color: widget.tile.hasMine ? Colors.red : Colors.grey,
      margin: const EdgeInsets.all(2),
      child: Center(child: Text(widget.tile.digit.toString())),
    );
  }
}
