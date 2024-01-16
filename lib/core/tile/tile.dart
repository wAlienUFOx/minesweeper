part 'tile.g.dart';

class Tile {
  int x;
  int y;
  bool hasMine;
  int digit;
  bool isOpen;
  bool hasFlag;
  bool ignore;
  void Function() callback;

  Tile({
    required this.x,
    required this.y,
    this.hasMine = false,
    this.digit = 0,
    this.isOpen = false,
    this.hasFlag = false,
    this.ignore = false,
    required this.callback
  });

  factory Tile.fromJson(Map<String, dynamic> json) => _$TileFromJson(json);
  Map<String, dynamic> toJson() => _$TileToJson(this);
}