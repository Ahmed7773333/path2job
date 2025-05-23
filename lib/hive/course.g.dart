// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CourseAdapter extends TypeAdapter<Course> {
  @override
  final int typeId = 1;

  @override
  Course read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Course(
      courseName: fields[0] as String?,
      courseDescription: fields[1] as String?,
      link: fields[2] as String?,
      numberOfvideos: fields[3] as int?,
      numberOfvideosDone: fields[4] as int?,
      done: fields[5] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, Course obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.courseName)
      ..writeByte(1)
      ..write(obj.courseDescription)
      ..writeByte(2)
      ..write(obj.link)
      ..writeByte(3)
      ..write(obj.numberOfvideos)
      ..writeByte(4)
      ..write(obj.numberOfvideosDone)
      ..writeByte(5)
      ..write(obj.done);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
