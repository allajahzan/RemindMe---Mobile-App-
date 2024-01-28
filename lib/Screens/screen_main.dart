import 'package:flutter/material.dart';
import 'package:remind_me_app/pages/set_reminder.dart';
import 'package:remind_me_app/pages/add_activity.dart';
import 'package:remind_me_app/pages/page_activities.dart';
import 'package:remind_me_app/pages/page_alarm.dart';

// ignore: must_be_immutable
class ScreenMain extends StatefulWidget {
  const ScreenMain({super.key});

  @override
  State<ScreenMain> createState() => _ScreenMainState();
}

class _ScreenMainState extends State<ScreenMain> {
  int pageIndex = 0;

  List<Widget> pages = [
    const PageAlarm(),
    const PageActivity(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: pages[pageIndex],
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        elevation: 30,
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Icon(
                Icons.alarm,
                size: 30,
              ),
            ),
            label: "Reminder",
            tooltip: "Reminder",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Icon(
                Icons.local_activity_outlined,
                size: 30,
              ),
            ),
            label: "Activities",
            tooltip: "Activities",
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onTap: () {
          if (pageIndex == 0) {
            Navigator.push(context, _createRoute());
          } else {
            Navigator.push(context, _createRoute1());
          }
        },
        child: CircleAvatar(
          radius: 45,
          // backgroundColor: Color.fromARGB(255, 121, 63, 223),
          backgroundColor: Colors.white,
          child: Material(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
            child: const CircleAvatar(
              radius: 35,
              backgroundColor: Color.fromARGB(255, 121, 63, 223),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return const AddReminder();
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.1, 0.0);
        const end = Offset.zero;
        const curve = Curves.fastEaseInToSlowEaseOut;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  Route _createRoute1() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return AddActivity();
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.1, 0.0);
        const end = Offset.zero;
        const curve = Curves.fastEaseInToSlowEaseOut;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
