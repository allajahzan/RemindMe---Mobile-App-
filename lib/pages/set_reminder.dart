import 'package:flutter/material.dart';
import 'package:remind_me_app/Database/activity_db.dart';
import 'package:remind_me_app/Database/reminder_db.dart';
import 'package:remind_me_app/model/reminder/reminder_model.dart';
import 'package:remind_me_app/services/notification_services.dart';
import 'package:remind_me_app/widgets/activity_picker.dart';
import 'package:remind_me_app/widgets/day_picker.dart';
import 'package:remind_me_app/widgets/elevated_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Day { Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday }

// ignore: must_be_immutable
class AddReminder extends StatefulWidget {
  const AddReminder({super.key});

  @override
  State<AddReminder> createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> {
  TextEditingController titleController = TextEditingController();

  // DateTime selectedDate = DateTime.now();

  // DateTime dateString = DateTime.now();

  String time = "Set Time";

  String activity = "Select Activity";

  String day = "Choose Day";

  Day? dayE;

  String hours = "00";

  String minutes = "00";

  int newId = -1;

  String? amORpm = "";

  List<Day> setDay = [
    Day.Monday,
    Day.Tuesday,
    Day.Wednesday,
    Day.Thursday,
    Day.Friday,
    Day.Saturday,
    Day.Sunday,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          elevation: 5,
          shadowColor: Colors.black,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 121, 63, 223),
                  Color.fromARGB(255, 142, 143, 250),
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
            ),
          ),
          leading: const Icon(null),
          leadingWidth: 0,
          title: Row(
            children: [
              Image.asset(
                "assets/images/Rme.png",
                width: 80,
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Material(
              elevation: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                color: const Color.fromARGB(255, 245, 245, 255),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Set Reminder",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          // InkWell(
                          //   onTap: () {
                          //     setReminder(time, activity, hours, minutes);
                          //   },
                          //   child: const Text(
                          //     "Save",
                          //     style: TextStyle(
                          //       fontSize: 18,
                          //       fontWeight: FontWeight.bold,
                          //       color: Color.fromARGB(255, 121, 63, 223),
                          //     ),
                          //   ),
                          // ),
                          const SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Cancel",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black45,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 0, top: 20),
              child: Column(
                children: [
                  // CupertinoTimerPicker(
                  //   mode: CupertinoTimerPickerMode.hm,
                  //   onTimerDurationChanged: (Duration newDuration) {
                  //     setTime(newDuration);
                  //   },
                  // ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              const Icon(
                                Icons.arrow_drop_up,
                                color: Colors.black26,
                                size: 35,
                              ),
                              SizedBox(
                                height: 163,
                                width: 60,
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (ctx, index) {
                                    return InkWell(
                                      splashColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      radius: 30,
                                      borderRadius: BorderRadius.circular(40),
                                      onTap: () {
                                        setState(() {
                                          time = "null";
                                        });
                                        if (index == 0) {
                                          setState(() {
                                            hours = "24";
                                          });
                                          setState(() {
                                            amORpm = "AM";
                                          });
                                        } else {
                                          if (index < 12) {
                                            setState(() {
                                              hours = "$index";
                                            });
                                            setState(() {
                                              amORpm = "AM";
                                            });
                                          } else {
                                            setState(() {
                                              hours = "$index";
                                            });
                                            setState(() {
                                              amORpm = "PM";
                                            });
                                          }
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 7, top: 7),
                                        child: CircleAvatar(
                                          backgroundColor: const Color.fromARGB(
                                              255, 237, 237, 237),
                                          radius: 20,
                                          child: Center(
                                            child: Text(
                                              "$index",
                                              style: const TextStyle(
                                                fontSize: 23,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: 24,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black26,
                                size: 35,
                              ),
                            ],
                          ),
                          const Text(
                            "hr",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              const Icon(
                                Icons.arrow_drop_up,
                                color: Colors.black26,
                                size: 35,
                              ),
                              SizedBox(
                                height: 163,
                                width: 60,
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (ctx, index) {
                                    return InkWell(
                                      splashColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      radius: 30,
                                      borderRadius: BorderRadius.circular(40),
                                      onTap: () {
                                        if (index == 0) {
                                          setState(() {
                                            minutes = "00";
                                          });
                                        } else {
                                          if (index < 10) {
                                            setState(() {
                                              minutes = "0$index";
                                            });
                                          } else {
                                            setState(() {
                                              minutes = index.toString();
                                            });
                                          }
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 7, top: 7),
                                        child: CircleAvatar(
                                          backgroundColor: const Color.fromARGB(
                                              255, 237, 237, 237),
                                          radius: 20,
                                          child: Text(
                                            "$index",
                                            style: const TextStyle(
                                              fontSize: 23,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: 60,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black26,
                                size: 35,
                              ),
                            ],
                          ),
                          const Text(
                            "min",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 237, 237, 237),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Text(
                            time == "null" ? "$hours:$minutes $amORpm" : time,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomDayPicker(
                    dropDownButton: SizedBox(
                      height: 50,
                      child: Center(
                        child: DropdownButton(
                            borderRadius: BorderRadius.circular(10),
                            hint: Padding(
                              padding: const EdgeInsets.only(left: 25),
                              child: Text(
                                dayE == null
                                    ? day
                                    : dayE.toString().split('.').last,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            underline: const Icon(null),
                            isExpanded: true,
                            items: setDay.map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(
                                  "Every ${item.toString().split('.').last}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                      color: Colors.black),
                                ),
                              );
                            }).toList(),
                            onChanged: (val) {
                              setState(() {
                                dayE = val!;
                              });
                            }),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomActivityPicker(
                    dropDownButton: SizedBox(
                      height: 50,
                      child: Center(
                        child: DropdownButton(
                            borderRadius: BorderRadius.circular(10),
                            hint: Padding(
                              padding: const EdgeInsets.only(left: 25),
                              child: Text(
                                activity,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            underline: const Icon(null),
                            isExpanded: true,
                            items: ActivityDB()
                                .activitiesListsNotifier
                                .value
                                .map((item) {
                              return DropdownMenuItem(
                                value: item.nameActivity,
                                child: Text(
                                  item.nameActivity,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                      color: Colors.black),
                                ),
                              );
                            }).toList(),
                            onChanged: (val) {
                              setState(() {
                                activity = val!;
                              });
                            }),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Opacity(
                  //   opacity: 0.1,
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(top: 0),
                  //     child: Image.asset(
                  //       "assets/images/Rme1.png",
                  //       width: 160,
                  //       height: 120,
                  //     ),
                  //   ),
                  // ),
                  CustomElevatedButton(
                    text: "Set Reminder",
                    function: () {
                      setReminder(time, activity, hours, minutes);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setReminder(
    String time,
    String activity,
    String hours,
    String minutes,
  ) async {
    if (dayE == null || time == "set Time" || activity == "Select Activity") {
      return null;
    } else {
      final item = ReminderModel(
        hour: int.parse(hours),
        minute: int.parse(minutes),
        activity: activity,
        day: dayE.toString(),
      );

      ReminderDB().setReminder(item);

      // get notification id from shared preferneces
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      final id = preferences.getString("notificationIdNew");

      if (id == null) {
        setState(() {
          newId = newId + 1;
        });
      } else {
        final value = int.parse(id);
        setState(() {
          newId = value + 1;
        });
      }

      // // store the notification id in shared preferneces
      await preferences.setString("notificationIdNew", newId.toString());

      final dayofWeek = dayE;
      final dayOfWeekValue = dayofWeek!.index;

      final now = DateTime.now();

      if (dayOfWeekValue < now.weekday ||
          (dayOfWeekValue == now.weekday &&
              (int.parse(hours) < now.hour ||
                  (int.parse(hours) == now.hour &&
                      int.parse(minutes) <= now.minute)))) {
        // If the specified day, hour, and minute are already past, schedule for the next week
        final daysUntilNextWeek = 7 - now.weekday + dayOfWeekValue;

        var scheduledDate = DateTime(
          now.year,
          now.month,
          now.day,
          int.parse(hours),
          int.parse(minutes),
        );

        final scheduledDates =
            scheduledDate.add(Duration(days: daysUntilNextWeek));

        // print(scheduledDates);

        final crctScheduled = scheduledDates;
        final dayofweeks = dayE.toString().split(".").last;
        // final dayofweekIn3letter = dayofweek[0] + dayofweek[1] + dayofweek[2];

        NotificationServices().showScheduledNotification(
          id: newId,
          title: "Hey...its time for ${activity.toLowerCase()}",
          body: dayofweeks.toUpperCase(),
          payload: "payload",
          scheduledDate: crctScheduled,
        );
      } else {
        var scheduledDate = DateTime(
          now.year,
          now.month,
          now.day,
          int.parse(hours),
          int.parse(minutes),
        );

        // Calculate next day of the week
        while (scheduledDate.weekday != dayOfWeekValue) {
          scheduledDate = scheduledDate.add(const Duration(days: 1));
        }

        final crctScheduled = scheduledDate;

        // print(crctScheduled);

        final dayofweeks = dayE.toString().split(".").last;
        // final dayofweekIn3letter = dayofweek[0] + dayofweek[1] + dayofweek[2];

        NotificationServices().showScheduledNotification(
          id: newId,
          title: "Hey...its time for ${activity.toLowerCase()}",
          body: dayofweeks.toUpperCase(),
          payload: "payload",
          scheduledDate: crctScheduled,
        );
      }
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }
}
