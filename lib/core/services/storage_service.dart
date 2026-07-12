import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const _secureStorage = FlutterSecureStorage();
  static const _tokenKey = 'session_token';
  static const _isLoggedInKey = 'is_logged_in';
  static const _emailKey = 'user_email';

  // Secure storage — session token
  static Future<void> saveSessionToken(String token) =>
      _secureStorage.write(key: _tokenKey, value: token);

  static Future<String?> readSessionToken() =>
      _secureStorage.read(key: _tokenKey);

  static Future<void> deleteSessionToken() =>
      _secureStorage.delete(key: _tokenKey);

  // Shared preferences — login state & email
  static Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, value);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  static Future<void> saveUserEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_emailKey, email);
  }

  static Future<String?> readUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_emailKey);
  }

  static Future<void> clearAll() async {
    await _secureStorage.deleteAll();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
