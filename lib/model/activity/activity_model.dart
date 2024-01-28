import 'package:hive_flutter/adapters.dart';
part 'activity_model.g.dart';

@HiveType(typeId: 1)
class ActivityModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String nameActivity;

  static int newId = 0;

  ActivityModel({required this.nameActivity}) {
    id = newId;
    newId++;
  }
}
