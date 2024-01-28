import 'package:flutter/material.dart';
import 'package:remind_me_app/Database/reminder_db.dart';
import 'package:remind_me_app/services/notification_services.dart';

enum Days { Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday }

// ignore: must_be_immutable
class CustomListTileAlarm extends StatefulWidget {
  const CustomListTileAlarm(
      {super.key,
      required this.day,
      required this.activity,
      required this.hour,
      required this.id,
      required this.isOn,
      required this.minute,
      required this.isAlramOn});

  final String day;
  final int hour;
  final int minute;
  final String activity;
  final int id;
  final bool isOn;
  final bool isAlramOn;

  @override
  State<CustomListTileAlarm> createState() => _CustomListTileAlarmState();
}

class _CustomListTileAlarmState extends State<CustomListTileAlarm> {
  List<String> daysOfweeks = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];

  num? dayValue;

  @override
  Widget build(BuildContext context) {
    final dayofweek = widget.day.split(".").last;
    final dayE = dayofweek[0] + dayofweek[1] + dayofweek[2];
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
      child: ListTile(
        leading: Container(
          width: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            gradient: widget.isOn && !widget.isAlramOn
                ? const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 121, 63, 223),
                      Color.fromARGB(255, 142, 143, 250),
                    ],
                  )
                : const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 156, 111, 233),
                      Color.fromARGB(255, 181, 182, 250),
                    ],
                  ),
          ),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 30,
            child: Text(
              widget.activity[0].toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ),
        ),
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.activity,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: widget.isOn && !widget.isAlramOn
                        ? Colors.black
                        : Colors.black54,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      dayE,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: widget.isOn && !widget.isAlramOn
                            ? Colors.black
                            : Colors.black54,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      (widget.hour == 0
                          ? "12:${widget.minute < 10 ? '0${widget.minute}' : widget.minute} AM"
                          : (widget.hour < 12
                              ? "${widget.hour}:${widget.minute < 10 ? '0${widget.minute}' : widget.minute} AM"
                              : "${widget.hour == 12 ? 12 : widget.hour - 12}:${widget.minute < 10 ? '0${widget.minute}' : widget.minute} PM")),
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: widget.isOn && !widget.isAlramOn
                            ? Colors.black
                            : Colors.black54,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
        trailing: widget.isAlramOn
            ? const Icon(
                Icons.toggle_off,
                size: 60,
                color: Colors.black26,
              )
            : InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  await ReminderDB().isToggleOn(!widget.isOn, widget.id);

                  if (widget.isOn == true) {
                    // print(widget.id);

                    await NotificationServices().cancelNotification(widget.id);

                    // print("Notification having ${widget.id} is off");
                  } else {
                    // print(widget.id);

                    await NotificationServices().cancelNotification(widget.id);

                    //  to set reminder again when we toggle on the toggle button

                    for (int i = 0; i <= 6; i++) {
                      if (widget.day.split(".").last == daysOfweeks[i]) {
                        setState(() {
                          dayValue = i;
                        });
                      }
                    }

                    // print(dayValue);

                    final now = DateTime.now();

                    if (dayValue! < now.weekday ||
                        (dayValue == now.weekday &&
                            (widget.hour < now.hour ||
                                (widget.hour == now.hour &&
                                    widget.minute <= now.minute)))) {
                      // If the specified day, hour, and minute are already past, schedule for the next week
                      // final daysUntilNextWeek = 7 - now.weekday + dayValue!;
                      const daysUntilNextWeek = 7;

                      var scheduledDate = DateTime(
                        now.year,
                        now.month,
                        now.day,
                        widget.hour,
                        widget.minute,
                      );

                      final scheduledDates = scheduledDate.add(Duration(
                          days: int.parse(daysUntilNextWeek.toString())));

                      final crctScheduled = scheduledDates;

                      // print(crctScheduled);

                      NotificationServices().showScheduledNotification(
                        id: widget.id,
                        title:
                            "Hey...its time for ${widget.activity.toLowerCase()}",
                        body: dayE.toUpperCase(),
                        payload: "payload",
                        scheduledDate: crctScheduled,
                      );

                      // Calculate next day of the week
                      // while (scheduledDate.weekday != dayValue) {
                      //   scheduledDate = scheduledDate.add(const Duration(days: 1));
                      // }
                    } else {
                      var scheduledDate = DateTime(
                        now.year,
                        now.month,
                        now.day,
                        widget.hour,
                        widget.minute,
                      );

                      // Calculate next day of the week
                      while (scheduledDate.weekday != dayValue) {
                        scheduledDate =
                            scheduledDate.add(const Duration(days: 1));
                      }

                      final crctScheduled = scheduledDate;

                      // print(crctScheduled);

                      // final dayofweeks = dayE.toString().split(".").last;`
                      // final dayofweekIn3letter = dayofweek[0] + dayofweek[1] + dayofweek[2];

                      NotificationServices().showScheduledNotification(
                        id: widget.id,
                        title:
                            "Hey...its time for ${widget.activity.toLowerCase()}",
                        body: dayE.toUpperCase(),
                        payload: "payload",
                        scheduledDate: crctScheduled,
                      );
                    }
                  }
                },
                child: widget.isOn
                    ? const Icon(
                        Icons.toggle_on,
                        size: 60,
                        color: Color.fromARGB(255, 121, 63, 223),
                      )
                    : const Icon(
                        Icons.toggle_off,
                        size: 60,
                        color: Colors.black26,
                      ),
              ),
      ),
    );
  }
}
