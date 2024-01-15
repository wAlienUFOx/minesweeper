// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaderboardItem _$LeaderboardItemFromJson(Map<String, dynamic> json) =>
    LeaderboardItem(
      time: json['time'] as int,
      dateTime: DateTime.parse(json['dateTime'] as String),
    );

Map<String, dynamic> _$LeaderboardItemToJson(LeaderboardItem instance) =>
    <String, dynamic>{
      'time': instance.time,
      'dateTime': instance.dateTime.toIso8601String(),
    };
