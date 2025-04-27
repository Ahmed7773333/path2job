import 'package:hive/hive.dart';
import 'package:path2job/hive_helper/hive_types.dart';
import 'package:path2job/hive_helper/hive_adapters.dart';
import 'package:path2job/hive_helper/fields/recent_acitivty_fields.dart';

part 'recent_acitivty.g.dart';

@HiveType(
    typeId: HiveTypes.recentAcitivty, adapterName: HiveAdapters.recentAcitivty)
class RecentAcitivty extends HiveObject {
  @HiveField(RecentAcitivtyFields.name)
  String? name;
  @HiveField(RecentAcitivtyFields.route)
  String? route;
  @HiveField(RecentAcitivtyFields.time)
  DateTime? time;

  RecentAcitivty({
    this.name,
    this.route,
    this.time,
  });
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'route': route,
      'time': time?.toIso8601String(),
    };
  }

  factory RecentAcitivty.fromJson(Map<String, dynamic> json) {
    return RecentAcitivty(
      name: json['name'],
      route: json['route'],
      time: DateTime.parse(json['time']),
    );
  }
  copyWith({
    String? name,
    String? route,
    DateTime? time,
  }) {
    return RecentAcitivty(
      name: name ?? this.name,
      route: route ?? this.route,
      time: time ?? this.time,
    );
  }
}
