import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
// saving data in Sharedpreferences

static String userLogedInKey = "LOGEDINKEY";
static String userNameKey = "USERNAMEKEY";
static String userEmailkey = "USEREMAILKEY";




//getting the data from shared pref
static Future<bool?> getUserLoginStatus() async{
  SharedPreferences sf = await SharedPreferences.getInstance();
  return sf.getBool(userLogedInKey);
}


}