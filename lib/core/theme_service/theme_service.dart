import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minesweeper/core/local_storage/local_storage.dart';

class ThemeService {
  late ThemeMode activeTheme;

  void initService() {
    String activeThemeMode = LocalStorage.themeMode ?? ThemeMode.light.name;

    if  (activeThemeMode == ThemeMode.light.name) {
      activeTheme = ThemeMode.light;
    } else {
      activeTheme = ThemeMode.dark;
    }

    Get.changeThemeMode(activeTheme);
  }

  void changeTheme() {
    if (activeTheme == ThemeMode.light) {
      activeTheme = ThemeMode.dark;
    } else {
      activeTheme = ThemeMode.light;
    }
    Get.changeThemeMode(activeTheme);
    LocalStorage.themeMode =  activeTheme.name;
  }
}