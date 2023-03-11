import 'dart:convert';
import 'package:music_team_mobile/api/src/token_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPref {
  final String _loggedIn = "LoggedIn";
  final String _tokenData = "tokenData";

  static SharedPreferences? _preferences;

  AppSharedPref._privateConstructor();

  static final AppSharedPref instance = AppSharedPref._privateConstructor();

  static Future<AppSharedPref> getInstance() async {
    return AppSharedPref.instance;
  }

  initSetup() async {
    _preferences = await SharedPreferences.getInstance();
  }

  void _saveToDisk<T>(String key, T content) {
    if (content is String) {
      _preferences?.setString(key, content);
    }
    if (content is bool) {
      _preferences?.setBool(key, content);
    }
    if (content is int) {
      _preferences?.setInt(key, content);
    }
    if (content is double) {
      _preferences?.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences?.setStringList(key, content);
    }
  }

  dynamic _getFromDisk(String key) {
    var value = _preferences!.get(key);
    // appPrint('(TRACE) AppSharedPref:_getFromDisk. key: $key value: $value');
    return value;
  }

  removeLoginDetails() {
    _preferences?.remove(_loggedIn);
  }

  void clearAllData() {
    _preferences!.clear();
  }

  /// Token Data
  set token(TokenModel? tokenModel) {
    _saveToDisk(_tokenData,
        tokenModel == null ? null : json.encode(tokenModel.toJson()));
  }

  TokenModel? get token {
    String? tokenJson = _getFromDisk(_tokenData);
    if (tokenJson == null) {
      return null;
    }
    return TokenModel.fromJson(json.decode(tokenJson));
  }

  int? get userId {
    return token?.userId;
  }

  /// Save logged-in flag
  set isLoggedIn(bool value) {
    _saveToDisk(_loggedIn, value);
  }

  bool get isLoggedIn {
    var data = _getFromDisk(_loggedIn);
    if (data != null) {
      return data;
    }
    return false;
  }
}
