import 'package:hive_flutter/adapters.dart';
part 'reminder_model.g.dart';

@HiveType(typeId: 2)
class ReminderModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? day;

  @HiveField(2)
  int? hour;

  @HiveField(3)
  int? minute;

  @HiveField(4)
  String? activity;

  @HiveField(5)
  bool isOn;

  @HiveField(6)
  bool isAlramOn;

  ReminderModel({
    required this.day,
    required this.hour,
    required this.minute,
    required this.activity,
    this.isOn = true,
    this.isAlramOn = false,
  });
}
