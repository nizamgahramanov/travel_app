import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences? _preferences;
  static const _keyLanguage = 'lang';
  static Future init() async => _preferences = await SharedPreferences.getInstance();
  static Future setLanguage(String langCode) async  =>
      await _preferences!.setString(_keyLanguage, langCode);

  static String? getLanguage() => _preferences!.getString(_keyLanguage);
}
