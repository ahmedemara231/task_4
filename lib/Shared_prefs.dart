import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper
{
  SharedPreferences? sharedPreferences;

  void init()async
  {
    sharedPreferences = await SharedPreferences.getInstance();
    print('shared prefs is ready');
  }

  Future<bool?> setMode({required key, required value})async
  {
    return await sharedPreferences?.setBool(key, value);
  }

  bool? getMode({required key})
  {
    return sharedPreferences?.getBool(key);
  }

}