import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrencesHelper {
  static late SharedPreferences shraredprefrences;

  static Future<SharedPreferences> initilazitonSharedPrefrences() async {
    return shraredprefrences = await SharedPreferences.getInstance();
  }

  static Future<bool> setData({required String key, required dynamic value}) async {
    if (value is String) return shraredprefrences.setString(key, value);
    if (value is int) return shraredprefrences.setInt(key, value);
    if (value is bool) return shraredprefrences.setBool(key, value);
    return shraredprefrences.setDouble(key, value);
  }

  static dynamic getData({String? key}) {
    return shraredprefrences.get(key!);
  }

  static Future<bool> clearData() async{
   return await shraredprefrences.clear();
  }
}
