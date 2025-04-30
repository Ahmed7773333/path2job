// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_acitivty.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecentAcitivtyAdapter extends TypeAdapter<RecentAcitivty> {
  @override
  final int typeId = 4;

  @override
  RecentAcitivty read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentAcitivty(
      name: fields[0] as String?,
      route: fields[1] as String?,
      time: fields[2] as DateTime?,
      icon: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, RecentAcitivty obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.route)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.icon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentAcitivtyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
