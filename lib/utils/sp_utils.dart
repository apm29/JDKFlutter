import 'package:shared_preferences/shared_preferences.dart' as sp;
import 'dart:async';

class SPUtils {
  static sp.SharedPreferences instance;

  static Future<bool> put(String key, dynamic) async {
    await checkInstance();
    bool success = false;
    switch (dynamic.runtimeType) {
      case String:
        success = await instance.setString(key, dynamic);
        break;
      case int:
        success = await instance.setInt(key, dynamic);
        break;
      case bool:
        success = await instance.setBool(key, dynamic);
        break;
      case double:
        success = await instance.setDouble(key, dynamic);
        break;
      case List:
        success = await instance.setStringList(key, dynamic);
        break;
    }
    return success;
  }

  static dynamic get(String key)async {
    await checkInstance();
    return instance.get(key);
  }

  static Future<bool> checkInstance() async {
    if (instance == null) {
      instance = await sp.SharedPreferences.getInstance();
    }
    return true;
  }
}
