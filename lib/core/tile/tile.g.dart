// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tile _$TileFromJson(Map<String, dynamic> json) => Tile(
      x: json['x'] as int,
      y: json['y'] as int,
      hasMine: json['hasMine'] as bool? ?? false,
      digit: json['digit'] as int? ?? 0,
      isOpen: json['isOpen'] as bool? ?? false,
      hasFlag: json['hasFlag'] as bool? ?? false,
      ignore: json['ignore'] as bool? ?? false,
    );

Map<String, dynamic> _$TileToJson(Tile instance) => <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'hasMine': instance.hasMine,
      'digit': instance.digit,
      'isOpen': instance.isOpen,
      'hasFlag': instance.hasFlag,
      'ignore': instance.ignore,
    };
