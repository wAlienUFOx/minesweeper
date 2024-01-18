import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minesweeper/core/local_storage/local_storage.dart';

class SettingsService {
  late FlagMode flagMode;
  late ThemeMode activeTheme;
  late bool wideBoundary;

  void initService() {
    String mode = LocalStorage.flagMode ?? FlagMode.doubleTap.name;
    if  (mode == FlagMode.doubleTap.name) {
      flagMode = FlagMode.doubleTap;
    } else {
      flagMode = FlagMode.longPress;
    }

    String activeThemeMode = LocalStorage.themeMode ?? ThemeMode.light.name;
    if  (activeThemeMode == ThemeMode.light.name) {
      activeTheme = ThemeMode.light;
    } else {
      activeTheme = ThemeMode.dark;
    }
    Get.changeThemeMode(activeTheme);

    String boundary = LocalStorage.boundaryMode ?? 'Off';
    if  (boundary == 'On') {
      wideBoundary = true;
    } else {
      wideBoundary = false;
    }
  }

  void switchFlagMode() {
    if (flagMode == FlagMode.doubleTap) {
      flagMode = FlagMode.longPress;
    } else {
      flagMode = FlagMode.doubleTap;
    }
    LocalStorage.flagMode = flagMode.name;
  }

  void changeTheme() {
    if (activeTheme == ThemeMode.light) {
      activeTheme = ThemeMode.dark;
    } else {
      activeTheme = ThemeMode.light;
    }
    Get.changeThemeMode(activeTheme);
    LocalStorage.themeMode = activeTheme.name;
  }

  void switchBoundaryMode() {
    wideBoundary = !wideBoundary;
    LocalStorage.boundaryMode = wideBoundary ? "On" : "Off";
  }
}

enum FlagMode {
  doubleTap,
  longPress
}