import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  static late final SharedPreferences storageInstance;
  static Future<void> init() async{
    storageInstance = await SharedPreferences.getInstance();
  }

  Future<bool?> getBoolData<T>(String key) async{
    final data = storageInstance.getBool(key);
    return data;
  }

  Future<bool?> storeBoolData(String key, bool value) async {
    final isStored = await storageInstance.setBool(key, value);
    return isStored;
  }

  Future<bool> clear() async{
    return await storageInstance.clear();
  }
}