// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_mode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameMode _$GameModeFromJson(Map<String, dynamic> json) => GameMode(
      width: json['width'] as int,
      height: json['height'] as int,
      mines: json['mines'] as int,
    );

Map<String, dynamic> _$GameModeToJson(GameMode instance) => <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
      'mines': instance.mines,
    };
