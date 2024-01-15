import 'package:json_annotation/json_annotation.dart';
part 'leaderboard_item.g.dart';

@JsonSerializable()
class LeaderboardItem {
  int time;
  DateTime dateTime;

  LeaderboardItem({
    required this.time,
    required this.dateTime
  });

  factory LeaderboardItem.fromJson(Map<String, dynamic> json) => _$LeaderboardItemFromJson(json);
  Map<String, dynamic> toJson() => _$LeaderboardItemToJson(this);
}