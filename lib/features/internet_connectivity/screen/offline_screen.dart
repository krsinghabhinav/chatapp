import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/internet_connctivity_controller.dart';

class OfflineScreen extends StatefulWidget {
  const OfflineScreen({super.key});

  @override
  State<OfflineScreen> createState() => _OfflineScreenState();
}

class _OfflineScreenState extends State<OfflineScreen> {
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
              Icons.wifi_off,
              color: Colors.red,
              size: 150,
            ),
            SizedBox(
              height: 15,
            ),
            Center(child: Text("No Internet Found")),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text("Try Again"),
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                _internetController.checkAndRetry();
              },
              child: Text("Retry to connect"),
            ),
          ],
        ),
      ),
    );
  }
}
