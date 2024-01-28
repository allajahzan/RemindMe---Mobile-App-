import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:remind_me_app/Database/reminder_db.dart';
import 'package:remind_me_app/Database/scheduledtimedate_db.dart';
import 'package:remind_me_app/model/ScheduledTime/scheduled_time_model.dart';
import 'package:remind_me_app/model/reminder/reminder_model.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationServices {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/icon');

    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            requestAlertPermission: true,
            requestSoundPermission: true,
            requestBadgePermission: true,
            onDidReceiveLocalNotification: (int? id, String? title,
                String? body, String? payload) async {});

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponce) async {});
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
          'your_channel_id',
          'your_channel_name',
          channelDescription: 'your_channel_description',
          playSound: true, // Enable sound
          sound: RawResourceAndroidNotificationSound('alaram'),
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
        ),
        iOS: DarwinNotificationDetails());
  }

  Future<void> showScheduledNotification({
    int? id,
    String? title,
    String? body,
    String? payload,
    DateTime? scheduledDate,
  }) async {
    print(scheduledDate);

    // store the scheduledTimeDate in data base with id
    final item = ScheduledDateTimeModel(datTime: scheduledDate, id: id);
    ScheduledDateTimeDB().addScheduledDateTime(item);
    // Schedule the current notification
    await scheduleNotification(id!, title!, body!, scheduledDate!);

    // Calculate the duration until the scheduled time
    Duration timeUntilScheduledTime = scheduledDate.difference(DateTime.now());
    // Wait until the scheduled time to come
    await Future.delayed(timeUntilScheduledTime);

    // check weather the alram is exist

    // print(id);
    final rimderDBNEWUpdated =
        await Hive.openBox<ReminderModel>("RimderDBNewUpdated");
    final data = rimderDBNEWUpdated.get(id);

    final scheduledDateTimeDb =
        await Hive.openBox<ScheduledDateTimeModel>("ScheduledDateTimeDATABASE");

    final datetime = scheduledDateTimeDb.get(id);

    if (data != null &&
        data.isOn == true &&
        datetime!.datTime!.isBefore(DateTime.now())) {
      await ReminderDB().isAlaramOn(true, id);
    }

    final result1 = await checkPendingId(id);
    // print(result1);

    if (result1 == true && datetime!.datTime!.isBefore(DateTime.now())) {
      await Future.delayed(const Duration(seconds: 60));
    }
    final result = await checkPendingId(id);
    // print(result);

    if (result == true && datetime!.datTime!.isBefore(DateTime.now())) {
      await ReminderDB().isAlaramOn(false, id);

      showScheduledNotification(
          id: id,
          body: body,
          title: title,
          scheduledDate: scheduledDate.add(const Duration(days: 7)));
    } else {
      if (data != null && data.isOn == false) {
        await ReminderDB().isAlaramOn(false, id);

        // print("success1");
      }
      // print("success2");
    }
  }

  Future<bool> checkPendingId(int id) async {
    // Check if the notification with the specified ID is still pending
    List<PendingNotificationRequest> pendingNotifications =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    bool isNotificationPending =
        pendingNotifications.any((notification) => notification.id == id);

    return isNotificationPending;
  }

  Future<void> scheduleNotification(
      int id, String title, String body, DateTime scheduledDate) async {
    flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      notificationDetails(),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exact,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }

//  to cancel the notification

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
    // final result = await checkPendingId(id);

    // print("$result = so alram off");
  }
}
