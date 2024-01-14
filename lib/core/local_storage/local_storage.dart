import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class LocalStorage {
  static final GetStorage _storage = Get.find<GetStorage>();

  static const String _keyThemeMode = 'THEME_MODE';
  static const String _keySavedField = 'SAVED_FIELD';

  static String? get themeMode => _storage.read(_keyThemeMode);
  static set themeMode(String? val) => _storage.write(_keyThemeMode, val);

  static Map<String, dynamic>? get savedField => _storage.read(_keySavedField);
  static set savedField(Map<String, dynamic>? val) => _storage.write(_keySavedField, val);
}