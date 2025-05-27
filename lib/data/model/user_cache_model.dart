import 'package:customer_app/utils/constants.dart';
import 'package:hive/hive.dart';

part 'user_cache_model.g.dart';

@HiveType(typeId: HiveTypeConstants.userCacheModelTypeId)
class UserCacheModel {
  @HiveField(0)
  final String? photoPath;

  @HiveField(1)
  final String? name;

  @HiveField(2)
  final String? phoneNumber;

  @HiveField(3)
  final String? emailId;

  @HiveField(4)
  final String? address;

  @HiveField(5)
  final double? lat;

  @HiveField(6)
  final double? lang;

  UserCacheModel({
    this.name,
    this.emailId,
    this.phoneNumber,
    this.photoPath,
    this.address,
    this.lang,
    this.lat,
  });
}