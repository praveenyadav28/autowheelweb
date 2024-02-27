import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  static late SharedPreferences preferences;

  static bool getBool(String key) {
    return preferences.getBool(key) ?? false;
  }

  static String getString(String key) {
    return preferences.getString(key) ?? "";
  }

  static int getint(String key) {
    return preferences.getInt(key) ?? 0;
  }

  static Future<bool> setBool(String key, bool value) async {
    return await preferences.setBool(key, value);
  }

  static Future<bool> setString(String key, String value) async {
    return await preferences.setString(key, value);
  }

  static Future<bool> setInt(String key, int value) async {
    return await preferences.setInt(key, value);
  }
}

class PrefKeys {
  static const userstatus = "userstatus";
  static const userId = "userId";
  static const id = "id";
  static const token = "token";
  static const firstName = "firstName";
  static const lastName = "lastName";
  static const image = "image";
  static const email = "email";
  static const isLightTheme = "isLightTheme";
  static const thememode = "thememode";
  static const darkmode = "dark";
  static const lightmode = "light";
  static const systemmode = "system";
}

logoutPrefData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove(PrefKeys.userstatus);
  await prefs.remove(PrefKeys.userId);
  await prefs.remove(PrefKeys.id);
  await prefs.remove(PrefKeys.token);
  await prefs.remove(PrefKeys.firstName);
  await prefs.remove(PrefKeys.lastName);
  await prefs.remove(PrefKeys.image);
  await prefs.remove(PrefKeys.email);
}
