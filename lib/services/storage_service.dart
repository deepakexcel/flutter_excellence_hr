import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class StorageUtil {
  static StorageUtil _storageUtil;
  static SharedPreferences _preferences;

  static Future<StorageUtil> getInstance() async {
    if (_storageUtil == null) {
      // keep local instance till it is fully initialized.
      var secureStorage = StorageUtil._();
      await secureStorage._init();
      _storageUtil = secureStorage;
    }
    return _storageUtil;
  }

  StorageUtil._();

  Future _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // get string
  static String getString(String key, {String defValue = ''}) {
    if (_preferences == null) return defValue;
    return _preferences.getString(key) ?? defValue;
  }

  // put string
  static Future<bool> putString(String key, String value) async {
    if (_preferences == null) return null;
    return _preferences.setString(key, value);
  }

  // put bool
  static Future<bool> putBool(String key, bool value) async {
    if (_preferences == null) return null;
    return _preferences.setBool(key, value);
  }

  // get string
  static bool getBool(String key, {bool defValue = false}) {
    if (_preferences == null) return defValue;
    return _preferences.getBool(key) ?? defValue;
  }
}
