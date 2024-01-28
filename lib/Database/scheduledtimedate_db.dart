import 'package:hive_flutter/hive_flutter.dart';
import 'package:remind_me_app/model/ScheduledTime/scheduled_time_model.dart';

abstract class ScheduledDateTimeDataBase {
  Future<void> addScheduledDateTime(ScheduledDateTimeModel item);
  Future<void> deleteScheduledDateTime(int id);
}

class ScheduledDateTimeDB implements ScheduledDateTimeDataBase {
  ScheduledDateTimeDB.internal();
  static ScheduledDateTimeDB instance = ScheduledDateTimeDB.internal();
  factory ScheduledDateTimeDB() {
    return instance;
  }

  @override
  Future<void> addScheduledDateTime(ScheduledDateTimeModel item) async {
    final scheduledDateTimeDb =
        await Hive.openBox<ScheduledDateTimeModel>("ScheduledDateTimeDATABASE");
    scheduledDateTimeDb.put(item.id!, item);
    // show();
  }

  // void show() async {
  //   final scheduledDateTimeDb =
  //       await Hive.openBox<ScheduledDateTimeModel>("ScheduledDateTimeDATABASE");
  //   for (int i = 0; i < scheduledDateTimeDb.length; i++) {
  //     final data = scheduledDateTimeDb.getAt(i);
  //     print("${data!.id}, ${data.datTime}");
  //   }
  // }

  @override
  Future<void> deleteScheduledDateTime(int id) async {
    final scheduledDateTimeDb =
        await Hive.openBox<ScheduledDateTimeModel>("ScheduledDateTimeDATABASE");
    scheduledDateTimeDb.delete(id);
  }
}
