import 'package:flutter/material.dart';
import 'package:remind_me_app/Database/activity_db.dart';

// ignore: must_be_immutable
class PageActivity extends StatelessWidget {
  const PageActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ActivityDB().activitiesListsNotifier,
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
                    //     "Add Activity",
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
                          left: 10, right: 10, top: 11, bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: const Color.fromARGB(255, 232, 230, 230),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 14, top: 14, bottom: 14, right: 0),
                        child: ListTile(
                          title: Text(
                            value[index].nameActivity,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                final id = value[index].id;
                                ActivityDB().deleteDbData(id!);
                              },
                              icon: const Icon(
                                Icons.delete,
                                size: 25,
                                color: Colors.black,
                              )),
                        ),
                      ));
                },
              );
      },
    );
  }
}
