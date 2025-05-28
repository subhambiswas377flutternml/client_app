import 'package:customer_app/data/model/user_cache_model.dart';
import 'package:customer_app/utils/cache_manager.dart';
import 'package:customer_app/utils/constants.dart';
import 'package:customer_app/utils/storage_manager.dart';

class AuthRepository {
  final StorageManager _storageManager = StorageManager();
  final CacheManager _cacheManager = CacheManager();
  AuthRepository();

  Future<bool?> authenticate({required String username, required String password}) async {
    if(username==AuthConstants.username&&password==AuthConstants.password){
      return await _storageManager.storeBoolData(StorageKeys.authStatus, true);
    }else{
      return false;
    }
  }

  Future<bool?> isAuthenticated() async{
    return await _storageManager.getBoolData(StorageKeys.authStatus);
  }

  Future<bool?> unAuthenticate() async{
    return await _storageManager.clear()&&await _cacheManager.clearBox<UserCacheModel>(HiveBoxKeys.userModelBoxKey);
  }
}