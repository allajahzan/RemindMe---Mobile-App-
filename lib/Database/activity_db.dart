import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:remind_me_app/model/activity/activity_model.dart';

abstract class ActivityDataBase {
  Future<void> addActivity(ActivityModel item);
  Future<List<ActivityModel>> getDbData();
  Future<void> deleteDbData(int id);
}

class ActivityDB implements ActivityDataBase {
  ValueNotifier<List<ActivityModel>> activitiesListsNotifier =
      ValueNotifier([]);

  ActivityDB.internal();
  static ActivityDB instance = ActivityDB.internal();
  factory ActivityDB() {
    return instance;
  }

  @override
  Future<void> addActivity(ActivityModel item) async {
    final activity_db = await Hive.openBox<ActivityModel>("DATABASE-ACTIVITY");
    activity_db.add(item);
    refresUI();

    // activity_db.clear();
    // activitiesListsNotifier.value.clear();
  }

  @override
  Future<List<ActivityModel>> getDbData() async {
    final activity_db = await Hive.openBox<ActivityModel>("DATABASE-ACTIVITY");
    return activity_db.values.toList();
  }

  void refresUI() async {
    activitiesListsNotifier.value.clear();

    final datas = await getDbData();
    activitiesListsNotifier.value.addAll(datas);
    activitiesListsNotifier.notifyListeners();
  }

  @override
  Future<void> deleteDbData(int id) async {
    final activity_db = await Hive.openBox<ActivityModel>("DATABASE-ACTIVITY");
    activity_db.delete(id);
    refresUI();
  }
}
