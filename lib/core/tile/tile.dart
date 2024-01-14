import 'package:json_annotation/json_annotation.dart';
part 'tile.g.dart';

@JsonSerializable()
class Tile {
  int x;
  int y;
  bool hasMine;
  int digit;
  bool isOpen;
  bool hasFlag;
  bool ignore;

  Tile({
    required this.x,
    required this.y,
    this.hasMine = false,
    this.digit = 0,
    this.isOpen = false,
    this.hasFlag = false,
    this.ignore = false
  });

  factory Tile.fromJson(Map<String, dynamic> json) => _$TileFromJson(json);
  Map<String, dynamic> toJson() => _$TileToJson(this);
}