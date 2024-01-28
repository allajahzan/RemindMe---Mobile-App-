import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomActivityPicker extends StatelessWidget {
  const CustomActivityPicker({super.key, required this.dropDownButton});

  final Widget dropDownButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const Text(
        //   "Activity",
        //   style: TextStyle(
        //       fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54),
        // ),
        // const SizedBox(
        //   height: 10,
        // ),
        Material(
          color: const Color.fromARGB(255, 237, 237, 237),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: dropDownButton,
        ),
      ],
    );
  }
}
