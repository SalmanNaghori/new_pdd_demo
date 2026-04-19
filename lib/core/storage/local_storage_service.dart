import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  final SharedPreferences _preferences;

  LocalStorageService(this._preferences);

  // KEYS
  static const String _authTokenKey = 'auth_token';
  static const String _themeKey = 'is_dark_theme';

  // Auth Token
  Future<bool> setAuthToken(String token) async {
    return await _preferences.setString(_authTokenKey, token);
  }

  String? getAuthToken() {
    return _preferences.getString(_authTokenKey);
  }

  Future<bool> clearAuthToken() async {
    return await _preferences.remove(_authTokenKey);
  }

  // Theme Config
  Future<bool> setThemeDark(bool isDark) async {
    return await _preferences.setBool(_themeKey, isDark);
  }

  bool? getThemeIsDark() {
    return _preferences.getBool(_themeKey);
  }
}
