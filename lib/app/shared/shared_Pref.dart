import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static String userLogedInKey = "LOGEDINKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailkey = "USEREMAILKEY";

  // saving data in Sharedpreferences
  static Future<bool> saveUserLogedinStatusSF(bool isUserLogedin) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLogedInKey, isUserLogedin);
  }

  static Future<bool> saveUserFullNameSF(String userName) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userNameKey, userName);
  }

  static Future<bool> saveUserEmailSF(String userEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailkey, userEmail);
  }

  //getting the data from shared pref
  static Future<bool?> getUserLoginStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLogedInKey);
  }

  static Future<String?> getUserEmail() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userEmailkey);
  }

  static Future<String?> getUserFullName() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userNameKey);
  }
}
