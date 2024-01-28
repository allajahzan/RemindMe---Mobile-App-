// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheduled_time_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScheduledDateTimeModelAdapter
    extends TypeAdapter<ScheduledDateTimeModel> {
  @override
  final int typeId = 3;

  @override
  ScheduledDateTimeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScheduledDateTimeModel(
      datTime: fields[0] as DateTime?,
      id: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ScheduledDateTimeModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.datTime)
      ..writeByte(1)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduledDateTimeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
