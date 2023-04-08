import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  //keys
  static String userLoggedInKey = "LOGGEDINKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userNumberKey = "USERNUMBERKEY";
  static String userEmailKey = "USEREMAILKEY";
  static String userDurumKey = "USERDURUMKEY";

  //saving the data to Sf

  static Future<bool> saveUserLoggedInStatus(bool isUserLoggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserNameSF(String userName) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userNameKey, userName);
  }

  static Future<bool> saveUserNumberSF(String userNumber) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userNumberKey, userNumber);
  }

  static Future<bool> saveUserEmailSF(String userEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailKey, userEmail);
  }

  static Future<bool> saveUserDurumSF(String userDurum) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userDurumKey, userDurum);
  }

  //getting the data from SF

  static Future<bool?> getUserLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoggedInKey);
  }

  static Future<String?> getUserEmailFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userEmailKey);
  }

  static Future<String?> getUserNameFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userNameKey);
  }

  static Future<String?> getUserNumberFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userNumberKey);
  }

  static Future<String?> getUserDurumFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userDurumKey);
  }

  static saveUserDurumFromSF() {}
}
