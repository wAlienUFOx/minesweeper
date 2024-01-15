import 'package:json_annotation/json_annotation.dart';
import 'package:minesweeper/core/game_service/game_field/game_field.dart';
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

  @override
  bool operator ==(covariant GameMode other) =>
      width == other.width && height == other.height && mines == other.mines;

  GameMode.beginner() : this(
    width: 9,
    height: 9,
    mines: 10
  );
  GameMode.medium() : this(
      width: 16,
      height: 16,
      mines: 40
  );
  GameMode.expert() : this(
      width: 16,
      height: 30,
      mines: 99
  );

  factory GameMode.fromJson(Map<String, dynamic> json) => _$GameModeFromJson(json);
  Map<String, dynamic> toJson() => _$GameModeToJson(this);

  @override
  int get hashCode => width.hashCode + height.hashCode + mines.hashCode;
}
