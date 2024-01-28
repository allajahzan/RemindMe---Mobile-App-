import 'package:flutter/material.dart';
import 'package:remind_me_app/Database/activity_db.dart';
import 'package:remind_me_app/model/activity/activity_model.dart';
import 'package:remind_me_app/widgets/elevated_button.dart';
import 'package:remind_me_app/widgets/text_form_field.dart';

// ignore: must_be_immutable
class AddActivity extends StatelessWidget {
  AddActivity({super.key});

  TextEditingController nameController = TextEditingController();

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
                        "Add Activity",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
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
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: nameController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomElevatedButton(
                    text: "Add Activity",
                    function: () {
                      addACtivity(context);
                    },
                  ),
                  // Opacity(
                  //   opacity: 0.1,
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(top: 0),
                  //     child: Image.asset(
                  //       "assets/images/Rme1.png",
                  //       width: 160,
                  //       height: 430,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addACtivity(BuildContext context) {
    final name = nameController.text.trim();
    if (name.isEmpty) {
      null;
    } else {
      final item = ActivityModel(nameActivity: name);
      ActivityDB().addActivity(item);
    }
    nameController.clear();
  }
}
