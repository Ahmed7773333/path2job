import 'package:hive/hive.dart';
import 'package:path2job/hive_helper/hive_types.dart';
import 'package:path2job/hive_helper/hive_adapters.dart';
import 'package:path2job/hive_helper/fields/favs_fields.dart';

part 'favs.g.dart';

@HiveType(typeId: HiveTypes.favs, adapterName: HiveAdapters.favs)
class FavoritModel extends HiveObject {
  @HiveField(FavsFields.id)
  int id;
  FavoritModel(this.id);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoritModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
