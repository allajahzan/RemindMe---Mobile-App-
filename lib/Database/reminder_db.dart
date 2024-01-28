import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:remind_me_app/model/reminder/reminder_model.dart';

abstract class ReminderDataBase {
  Future<void> setReminder(ReminderModel item);
  Future<List<ReminderModel>> getDbData();
  Future<void> isToggleOn(bool result, int id);
  Future<void> isAlaramOn(bool result, int id);
  Future<void> deleteDbData(int id);
}

class ReminderDB implements ReminderDataBase {
  ValueNotifier<List<ReminderModel>> remindersListsNotifier = ValueNotifier([]);

  ReminderDB.internal();
  static ReminderDB instance = ReminderDB.internal();
  factory ReminderDB() {
    return instance;
  }

  @override
  Future<void> setReminder(ReminderModel item) async {
    final rimderDBNEWUpdated =
        await Hive.openBox<ReminderModel>("RimderDBNewUpdated");

    // remindersListsNotifier.value.clear();
    // rimderDBNEWUpdated.clear();

    int id = await rimderDBNEWUpdated.add(item);
    item.id = id;

    rimderDBNEWUpdated.put(id, item);
    refresUI();
  }

  @override
  Future<List<ReminderModel>> getDbData() async {
    final rimderDBNEWUpdated =
        await Hive.openBox<ReminderModel>("RimderDBNewUpdated");
    return rimderDBNEWUpdated.values.toList();
  }

  void refresUI() async {
    remindersListsNotifier.value.clear();
    final datas = await getDbData();
    remindersListsNotifier.value.addAll(datas);
    remindersListsNotifier.notifyListeners();
  }

  @override
  Future<void> isToggleOn(bool result, int id) async {
    final rimderDBNEWUpdated =
        await Hive.openBox<ReminderModel>("RimderDBNewUpdated");
    final data = rimderDBNEWUpdated.get(id);
    data!.isOn = result;
    await rimderDBNEWUpdated.put(id, data);
    refresUI();
  }

  @override
  Future<void> isAlaramOn(bool result, int id) async {
    final rimderDBNEWUpdated =
        await Hive.openBox<ReminderModel>("RimderDBNewUpdated");
    final data = rimderDBNEWUpdated.get(id);
    data!.isAlramOn = result;
    await rimderDBNEWUpdated.put(id, data);
    refresUI();
  }

  @override
  Future<void> deleteDbData(int id) async {
    final rimderDBNEWUpdated =
        await Hive.openBox<ReminderModel>("RimderDBNewUpdated");
    rimderDBNEWUpdated.delete(id);
    refresUI();
  }
}
