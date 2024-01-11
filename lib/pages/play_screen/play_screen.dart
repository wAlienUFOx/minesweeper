import 'package:flutter/material.dart';
import 'package:minesweeper/widgets/abstract_state.dart';

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
  int mines = 15;

  @override
  void onInitPage() {

    super.onInitPage();
  }

  @override
  Widget build(BuildContext context) {
    double tileSize = MediaQuery.of(context).size.width / width;

    return const Placeholder();
  }
}
