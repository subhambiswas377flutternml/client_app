import 'dart:io';

import 'package:customer_app/data/model/user_cache_model.dart';
import 'package:customer_app/utils/constants.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CacheManager {
  static final HiveInterface _hive = Hive;
  CacheManager();

  static Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
    final String path = join(directory.path, 'cache_storage');
    if (!(await Directory(path).exists())) {
      await Directory(path).create();
    }
    _hive.init(path);

    await CacheDtoAdapters.call(_hive);
  }

  Future<bool> insertData<T>(
    String boxKey,
    T data,
  ) async {
    try {
      final box = _hive.box<T>(boxKey);
      await box.add(data);
      return true;
    } catch (ex, _) {
      return false;
    }
  }


  Future<List<T>?> getAll<T>(
    String boxKey,
  ) async {
    try {
      final box = _hive.box<T>(boxKey);
      final dataList = box.values.toList();
      return dataList;
    } catch (ex, _) {
      return null;
    }
  }

  Future<bool> removeAtIndex<T>(
    String boxKey,
    int index
    ) async {
    try{
      final box = _hive.box<T>(boxKey);
      final dataList = box.values.toList();

      if(dataList.length-1<index){
        return false;
      }else{
        box.deleteAt(index);
        return true;
      }
    }catch(ex, _){
      return false;
    }
  }
}

class CacheDtoAdapters {
  static Future<void> call(HiveInterface hive) async {
    hive.registerAdapter<UserCacheModel>(UserCacheModelAdapter());
    await hive.openBox<UserCacheModel>(
      HiveBoxKeys.userModelBoxKey,
    );
  }
}