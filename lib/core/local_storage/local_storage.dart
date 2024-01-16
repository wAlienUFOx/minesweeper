import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class LocalStorage {
  static final GetStorage _storage = Get.find<GetStorage>();

  static const String _keyThemeMode = 'THEME_MODE';
  static const String _keyVibrationMode = 'VIBRATION_MODE';
  static const String _keySavedField = 'SAVED_FIELD';
  static const String _keyCustomMode = 'CUSTOM_MODE';
  static const String _keyLeaderboard = 'LEADERBOARD';

  static String? get themeMode => _storage.read(_keyThemeMode);
  static set themeMode(String? val) => _storage.write(_keyThemeMode, val);

  static String? get vibrationMode => _storage.read(_keyVibrationMode);
  static set vibrationMode(String? val) => _storage.write(_keyVibrationMode, val);

  static Map<String, dynamic>? get savedField => _storage.read(_keySavedField);
  static set savedField(Map<String, dynamic>? val) => _storage.write(_keySavedField, val);

  static Map<String, dynamic>? get customMode => _storage.read(_keyCustomMode);
  static set customMode(Map<String, dynamic>? val) => _storage.write(_keyCustomMode, val);

  static Map<String, dynamic>? get leaderboard => _storage.read(_keyLeaderboard);
  static set leaderboard(Map<String, dynamic>? val) => _storage.write(_keyLeaderboard, val);
}