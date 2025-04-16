import 'package:hive/hive.dart';
import 'package:path2job/hive_helper/hive_types.dart';
import 'package:path2job/hive_helper/hive_adapters.dart';
import 'package:path2job/hive_helper/fields/user_model_fields.dart';

part 'user.g.dart';

@HiveType(typeId: HiveTypes.userModel, adapterName: HiveAdapters.userModel)
class UserModel extends HiveObject {
  @HiveField(UserModelFields.email)
  final String email;

  @HiveField(UserModelFields.name)
  final String? name;

  @HiveField(UserModelFields.phone)
  final String? phone;

  @HiveField(UserModelFields.job)
  final String? job;

  UserModel({
    required this.email,
    this.name,
    this.phone,
    this.job,
  });
}
