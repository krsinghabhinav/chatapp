import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/internet_connctivity_controller.dart';

class OnlineScreen extends StatefulWidget {
  const OnlineScreen({super.key});

  @override
  State<OnlineScreen> createState() => _OnlineScreenState();
}

class _OnlineScreenState extends State<OnlineScreen> {
  InternetConnectivityController _internetController =
      Get.put(InternetConnectivityController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.online_prediction,
              color: Colors.green,
              size: 180,
            ),
            SizedBox(
              height: 15,
            ),
            Center(child: Text("Internet Found")),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
