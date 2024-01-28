import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:remind_me_app/Screens/screen_progress.dart';
import 'package:remind_me_app/model/ScheduledTime/scheduled_time_model.dart';
import 'package:remind_me_app/model/activity/activity_model.dart';
import 'package:remind_me_app/model/reminder/reminder_model.dart';
import 'package:remind_me_app/services/notification_services.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationServices().init();
  tz.initializeTimeZones();
  // Initialize Hive first
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(ActivityModelAdapter().typeId)) {
    Hive.registerAdapter(ActivityModelAdapter());
  }
  if (!Hive.isAdapterRegistered(ReminderModelAdapter().typeId)) {
    Hive.registerAdapter(ReminderModelAdapter());
  }
  if (!Hive.isAdapterRegistered(ScheduledDateTimeModelAdapter().typeId)) {
    Hive.registerAdapter(ScheduledDateTimeModelAdapter());
  }

  // Request notification permissions
  await _requestPermissions();

  runApp(const MyApp());
}

Future<void> _requestPermissions() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.notification,
  ].request();

  // You can check the status of the permissions if needed
  print("Notification status: ${statuses[Permission.notification]}");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScreenProgress(),
    );
  }
}
