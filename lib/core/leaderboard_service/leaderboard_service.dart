import 'package:minesweeper/core/game_service/game_mode/game_mode.dart';
import 'package:minesweeper/core/leaderboard_service/leaderboard/leaderboard.dart';
import 'package:minesweeper/core/leaderboard_service/leaderboard_item/leaderboard_item.dart';
import 'package:minesweeper/core/local_storage/local_storage.dart';

class LeaderboardService {
  late Leaderboard leaderboard;

  void initService() {
    if (LocalStorage.leaderboard != null) {
      leaderboard = Leaderboard.fromJson(LocalStorage.leaderboard!);
    } else {
      leaderboard = Leaderboard(beginner: [], medium: [], expert: []);
    }
  }

  void add(int record, GameMode gameMode) {
    if (gameMode == GameMode.beginner()) {
      leaderboard.beginner.add(LeaderboardItem(time: record, dateTime: DateTime.now()));
      leaderboard.beginner.sort((a, b) => sortItems(a, b));
    } else if (gameMode == GameMode.medium()) {
      leaderboard.medium.add(LeaderboardItem(time: record, dateTime: DateTime.now()));
      leaderboard.medium.sort((a, b) => sortItems(a, b));
    } else if (gameMode == GameMode.expert()) {
      leaderboard.expert.add(LeaderboardItem(time: record, dateTime: DateTime.now()));
      leaderboard.expert.sort((a, b) => sortItems(a, b));
    } else {
      return;
    }
    LocalStorage.leaderboard = leaderboard.toJson();
  }

  void remove(LeaderboardItem item, GameMode gameMode) {
    if (gameMode == GameMode.beginner()) {
      leaderboard.beginner.remove(item);
    } else if (gameMode == GameMode.medium()) {
      leaderboard.medium.remove(item);
    } else if (gameMode == GameMode.expert()) {
      leaderboard.expert.remove(item);
    } else {
      return;
    }
    LocalStorage.leaderboard = leaderboard.toJson();
  }

  int sortItems(LeaderboardItem a, LeaderboardItem b) {
    if (a.time > b.time) return 1;
    if (a.time < b.time) return -1;
    return 0;
  }
}