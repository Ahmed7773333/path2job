import 'dart:typed_data';

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
  @HiveField(UserModelFields.photo_url)
  final String? photoUrl;
  @HiveField(UserModelFields.photo_local)
  final Uint8List? photoLocal;

  UserModel({
    required this.email,
    this.name,
    this.phone,
    this.job,
    this.photoUrl,
    this.photoLocal,
  });
  CopyWith({
    String? email,
    String? name,
    String? phone,
    String? job,
    String? photoUrl,
    Uint8List? photoLocal,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      job: job ?? this.job,
      photoUrl: photoUrl ?? this.photoUrl,
      photoLocal: photoLocal ?? this.photoLocal,
    );
  }
}
