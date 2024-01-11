import 'package:flutter/material.dart';

class TileWidget extends StatefulWidget {
  final bool isOpen;
  final bool hasMine;
  final double size;
  
  const TileWidget({
    required this.isOpen,
    required this.hasMine,
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
      color: Colors.green,
      padding: const EdgeInsets.all(1),
    );
  }
}
