import 'package:minesweeper/core/local_storage/local_storage.dart';

class FlagSettingsService {
  late FlagMode flagMode;

  void initService() {
    String mode = LocalStorage.flagMode ?? FlagMode.doubleTap.name;

    if  (mode == FlagMode.doubleTap.name) {
      flagMode = FlagMode.doubleTap;
    } else {
      flagMode = FlagMode.longPress;
    }
  }

  void switchMode() {
    if (flagMode == FlagMode.doubleTap) {
      flagMode = FlagMode.longPress;
    } else {
      flagMode = FlagMode.doubleTap;
    }
    LocalStorage.flagMode = flagMode.name;
  }
}

enum FlagMode {
  doubleTap,
  longPress
}