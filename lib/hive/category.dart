import 'package:hive/hive.dart';
import 'package:path2job/hive_helper/hive_types.dart';
import 'package:path2job/hive_helper/hive_adapters.dart';
import 'package:path2job/hive_helper/fields/category_fields.dart';
import 'package:path2job/hive_helper/user_hive_helper.dart';

part 'category.g.dart';

@HiveType(typeId: HiveTypes.category, adapterName: HiveAdapters.category)
class Categories extends HiveObject {
  @HiveField(CategoryFields.numberOfQuestions)
  int? numberOfQuestions;
  @HiveField(CategoryFields.name)
  String? name;

  Categories({this.numberOfQuestions, this.name});
  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
        numberOfQuestions: json['numberOfQuestions'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['numberOfQuestions'] = numberOfQuestions;
    data['name'] = name;
    data['key'] = UserHiveHelper.getUser()?.email;
    return data;
  }

  copyWith({
    int? numberOfQuestions,
    String? name,
  }) {
    return Categories(
      numberOfQuestions: numberOfQuestions ?? this.numberOfQuestions,
      name: name ?? this.name,
    );
  }
}
