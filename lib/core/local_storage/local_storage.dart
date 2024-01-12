import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:minesweeper/core/game_service/tile.dart';

class LocalStorage {
  static final GetStorage _storage = Get.find<GetStorage>();

  static const String _keyThemeMode = 'THEME_MODE';
  static const String _keySavedField = 'SAVED_FIELD';
  static const String _keySavedTimer = 'SAVED_TIMER';
  static const String _keySavedMines = 'SAVED_MINES';

  static String? get themeMode => _storage.read(_keyThemeMode);
  static set themeMode(String? val) => _storage.write(_keyThemeMode, val);

  static List<List<Tile>> get savedField => _storage.read(_keySavedField);
  static set savedField(List<List<Tile>> val) => _storage.write(_keySavedField, val);
  static bool hasSavedField() => _storage.hasData(_keySavedField);
  static void clearSavedField() => _storage.remove(_keySavedField);

  static int get savedTimer => _storage.read(_keySavedTimer);
  static set savedTimer(int val) => _storage.write(_keySavedTimer, val);

  static int get savedMines => _storage.read(_keySavedMines);
  static set savedMines(int val) => _storage.write(_keySavedMines, val);
}