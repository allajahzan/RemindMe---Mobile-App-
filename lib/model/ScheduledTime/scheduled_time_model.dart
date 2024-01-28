import 'package:hive_flutter/hive_flutter.dart';
part 'scheduled_time_model.g.dart';

@HiveType(typeId: 3)
class ScheduledDateTimeModel {
  @HiveField(0)
  DateTime? datTime;

  @HiveField(1)
  int? id;

  ScheduledDateTimeModel({required this.datTime, required this.id});
}
