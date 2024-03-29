import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:minesweeper/core/leaderboard_service/leaderboard_service.dart';
import 'package:minesweeper/core/settings_service/settings_service.dart';
import 'package:minesweeper/core/vibration_service/vibration_service.dart';

import 'game_service/game_service.dart';

class AppBindings extends Bindings {
  @override
  Future<void> dependencies() async {
    Get.lazyPut<GetStorage>(() => GetStorage(), fenix: true);

    Get.put(LeaderboardService());
    Get.put(SettingsService());
    Get.put(VibrationService());
    Get.put(GameService());
  }
}