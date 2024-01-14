import 'package:minesweeper/core/game_field/game_field.dart';

class GameMode {
  final int width;
  final int height;
  final int mines;

  GameMode({
    required this.width,
    required this.height,
    required this.mines
  });

  GameMode.fromGameField(GameField field) : this(
      width: field.width,
      height: field.height,
      mines: field.mines
  );
}
