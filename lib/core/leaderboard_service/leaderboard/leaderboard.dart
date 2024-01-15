import 'package:json_annotation/json_annotation.dart';
import 'package:minesweeper/core/leaderboard_service/leaderboard_item/leaderboard_item.dart';
part 'leaderboard.g.dart';

@JsonSerializable()
class Leaderboard {
  List<LeaderboardItem> beginner;
  List<LeaderboardItem> medium;
  List<LeaderboardItem> expert;

  Leaderboard({
    required this.beginner,
    required this.medium,
    required this.expert
  });

  factory Leaderboard.fromJson(Map<String, dynamic> json) => _$LeaderboardFromJson(json);
  Map<String, dynamic> toJson() => _$LeaderboardToJson(this);
}