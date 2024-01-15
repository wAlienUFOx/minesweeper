// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Leaderboard _$LeaderboardFromJson(Map<String, dynamic> json) => Leaderboard(
      beginner: (json['beginner'] as List<dynamic>)
          .map((e) => LeaderboardItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      medium: (json['medium'] as List<dynamic>)
          .map((e) => LeaderboardItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      expert: (json['expert'] as List<dynamic>)
          .map((e) => LeaderboardItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LeaderboardToJson(Leaderboard instance) =>
    <String, dynamic>{
      'beginner': instance.beginner,
      'medium': instance.medium,
      'expert': instance.expert,
    };
