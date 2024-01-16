// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_field.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameField _$GameFieldFromJson(Map<String, dynamic> json) => GameField(
      field: (json['field'] as List<dynamic>)
          .map((e) => (e as List<dynamic>)
              .map((e) => Tile.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
      width: json['width'] as int? ?? 0,
      height: json['height'] as int? ?? 0,
      mines: json['mines'] as int? ?? 0,
      savedTimer: json['savedTimer'] as int? ?? 0,
      openTiles: json['openTiles'] as int? ?? 0,
      newGame: json['newGame'] as bool? ?? true,
    );

Map<String, dynamic> _$GameFieldToJson(GameField instance) => <String, dynamic>{
      'field': instance.field,
      'width': instance.width,
      'height': instance.height,
      'mines': instance.mines,
      'savedTimer': instance.savedTimer,
      'openTiles': instance.openTiles,
      'newGame': instance.newGame,
    };
