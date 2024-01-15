import 'package:json_annotation/json_annotation.dart';
import 'package:minesweeper/core/game_field/game_field.dart';
part 'game_mode.g.dart';

@JsonSerializable()
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

  factory GameMode.fromJson(Map<String, dynamic> json) => _$GameModeFromJson(json);
  Map<String, dynamic> toJson() => _$GameModeToJson(this);
}
