
 import 'package:shared_preferences/shared_preferences.dart';

class CashHelper{

  static SharedPreferences ?sharedPreferences;

  static init() async
  {

    sharedPreferences = await SharedPreferences.getInstance();

  }


  static Future <bool?> setBool(
  {
    required String key,
    required bool check,
 })async{

   return  await sharedPreferences?.setBool(key, check);
  }

  static bool? getBool(
      {
        required String key,
      }){

      return sharedPreferences?.getBool(key);
  }

 }