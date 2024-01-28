import 'package:flutter/material.dart';
import 'package:remind_me_app/Database/activity_db.dart';
import 'package:remind_me_app/Database/reminder_db.dart';
import 'package:remind_me_app/Screens/screen_main.dart';

class ScreenProgress extends StatefulWidget {
  const ScreenProgress({super.key});

  @override
  State<ScreenProgress> createState() => _ScreenProgressState();
}

class _ScreenProgressState extends State<ScreenProgress> {
  @override
  void initState() {
    super.initState();
    ActivityDB().refresUI();
    ReminderDB().refresUI();
  }

  @override
  Widget build(BuildContext context) {
    router(context);
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Color.fromARGB(255, 121, 63, 223),
          Color.fromARGB(255, 142, 143, 250),
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/title1.gif",
            width: 250,
          ),
          // const SizedBox(
          //   height: 20,
          // ),
          // SizedBox(
          //   width: MediaQuery.of(context).size.width / 4,
          //   child: LinearProgressIndicator(
          //     borderRadius: BorderRadius.circular(20),
          //   ),
          // ),
        ],
      ),
    );
  }

  void router(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));

    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return const ScreenMain();
    }));
  }
}
