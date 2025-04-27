import 'package:hive/hive.dart';
import 'package:path2job/hive_helper/hive_types.dart';
import 'package:path2job/hive_helper/hive_adapters.dart';
import 'package:path2job/hive_helper/fields/course_fields.dart';
import 'package:path2job/hive_helper/user_hive_helper.dart';

part 'course.g.dart';

@HiveType(typeId: HiveTypes.course, adapterName: HiveAdapters.course)
class Course extends HiveObject {
  @HiveField(CourseFields.courseName)
  final String? courseName;
  @HiveField(CourseFields.courseDescription)
  final String? courseDescription;
  @HiveField(CourseFields.link)
  final String? link;
  @HiveField(CourseFields.numberOfvideos)
  final int? numberOfvideos;
  @HiveField(CourseFields.numberOfvideosDone)
  final int? numberOfvideosDone;
  @HiveField(CourseFields.done)
  final bool? done;

  Course(
      {this.courseName,
      this.courseDescription,
      this.link,
      this.numberOfvideos,
      this.numberOfvideosDone,
      this.done});
  Map<String, dynamic> toJson() {
    return {
      'name': courseName,
      'description': courseDescription,
      'link': link,
      'numberOfvideos': numberOfvideos,
      'numberOfvideosDone': numberOfvideosDone,
      'done': done,
      'key': UserHiveHelper.getUser()?.email,
    };
  }

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      courseName: json['name'],
      courseDescription: json['description'],
      link: json['link'],
      numberOfvideos: json['numberOfvideos'],
      numberOfvideosDone: json['numberOfvideosDone'],
      done: json['done'],
    );
  }
  copyWith({
    String? courseName,
    String? courseDescription,
    String? link,
    int? numberOfvideos,
    int? numberOfvideosDone,
    bool? done,
  }) {
    return Course(
      courseName: courseName ?? this.courseName,
      courseDescription: courseDescription ?? this.courseDescription,
      link: link ?? this.link,
      numberOfvideos: numberOfvideos ?? this.numberOfvideos,
      numberOfvideosDone: numberOfvideosDone ?? this.numberOfvideosDone,
      done: done ?? this.done,
    );
  }
}
