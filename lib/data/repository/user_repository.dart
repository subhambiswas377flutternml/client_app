import 'package:customer_app/data/model/user_cache_model.dart';
import 'package:customer_app/utils/cache_manager.dart';
import 'package:customer_app/utils/constants.dart';

class UserRepository {
  final CacheManager _cacheManager = CacheManager();

  Future<List<UserCacheModel>?> storeUserData({required UserCacheModel data}) async {
    final isSaved = await _cacheManager.insertData<UserCacheModel>(HiveBoxKeys.userModelBoxKey, data);
    if(isSaved){
      return await getAllData();
    }else{
      return null;
    }
  }

  Future<List<UserCacheModel>?> getAllData() async{
    final List<UserCacheModel>? data = await _cacheManager.getAll(HiveBoxKeys.userModelBoxKey);
    return data;
  }

  Future<List<UserCacheModel>?> deleteUser(int index) async{
    final isRemoved = await _cacheManager.removeAtIndex<UserCacheModel>(HiveBoxKeys.userModelBoxKey, index);
    if(isRemoved){
      return await getAllData();
    }else{
      return null;
    }
  }
}