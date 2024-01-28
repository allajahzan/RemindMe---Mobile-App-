import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:remind_me_app/Database/reminder_db.dart';
import 'package:remind_me_app/Database/scheduledtimedate_db.dart';
import 'package:remind_me_app/services/notification_services.dart';
import 'package:remind_me_app/widgets/list_tile_alarm.dart';

// ignore: must_be_immutable
class PageAlarm extends StatefulWidget {
  const PageAlarm({super.key});

  @override
  State<PageAlarm> createState() => _PageAlarmState();
}

class _PageAlarmState extends State<PageAlarm> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ReminderDB().remindersListsNotifier,
      builder: (context, value, child) {
        return value.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Opacity(
                      opacity: 0.1,
                      child: Image.asset(
                        "assets/images/Rme1.png",
                        width: 160,
                      ),
                    ),
                    // Opacity(
                    //   opacity: 0.2,
                    //   child: Text(
                    //     "Set Reminder",
                    //     style: TextStyle(
                    //       fontSize: 18,
                    //       fontWeight: FontWeight.w500,
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              )
            : ListView.builder(
                padding:
                    const EdgeInsets.only(top: 7, left: 5, right: 5, bottom: 7),
                itemCount: value.length,
                itemBuilder: (ctx, index) {
                  return Container(
                    margin: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 10, top: 11),
                    child: Slidable(
                      key: Key(value[index].id.toString()),
                      direction: Axis.horizontal,
                      startActionPane: value[index].isAlramOn
                          ? null
                          : ActionPane(
                              extentRatio: 0.30,
                              motion: const BehindMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (BuildContext context) async {
                                    final id = value[index].id!;
                                    ReminderDB().deleteDbData(id);
                                    await NotificationServices()
                                        .cancelNotification(id);
                                    ScheduledDateTimeDB()
                                        .deleteScheduledDateTime(id);
                                  },
                                  foregroundColor: Colors.black,
                                  backgroundColor: Colors.transparent,
                                  icon: Icons.delete,
                                  label: "Delete",
                                  borderRadius: BorderRadius.circular(60),
                                ),
                              ],
                            ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          color: const Color.fromARGB(255, 232, 230, 230),
                        ),
                        child: CustomListTileAlarm(
                          day: value[index].day!,
                          hour: value[index].hour!,
                          minute: value[index].minute!,
                          activity: value[index].activity!,
                          id: value[index].id!,
                          isOn: value[index].isOn,
                          isAlramOn: value[index].isAlramOn,
                        ),
                      ),
                    ),
                  );
                },
              );
      },
    );
  }
}
