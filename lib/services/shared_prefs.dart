import 'dart:async' show Future;
import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static late SharedPreferences _prefs;

  static Future<SharedPreferences> init() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }

  static Future<bool> setString(String key, String value) async {
    var res = await _prefs.setString(key, value);
    await Prefs.init();
    return res;
  }

  static String? getString(String key) => _prefs.getString(key);

  static Future<bool>? remove(String key) async => await _prefs.remove(key);

  static Future<bool>? clear() async => await _prefs.clear();
}

String SETPIN = "SETPIN";
