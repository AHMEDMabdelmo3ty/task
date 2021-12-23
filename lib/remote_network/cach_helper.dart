import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static dynamic getData( String key ) {
    return sharedPreferences!.get(key);
  }

  static Future saveData  ({required String key, required String value}) async {
    await sharedPreferences!.setString(key, value);

  }

  static Future<bool> removeData(String key) async {
    return await sharedPreferences!.remove(key);
  }
}
