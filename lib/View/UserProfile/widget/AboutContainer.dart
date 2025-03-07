import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutContainer extends StatelessWidget {
  const AboutContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
          height: Get.height * 0.18,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text("About",
                    style: TextStyle(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 18)),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                child: Text(
                    "My name is abhinav i am new here to using sampark app for communication with my friend My name is abhinav i am new here to using sampark app for",
                    style: TextStyle(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 15)),
              ),
            ],
          )),
    );
  }
}
