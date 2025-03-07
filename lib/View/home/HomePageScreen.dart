import 'package:chatapp/controller/chatController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

import '../../config/images.dart';
import '../../controller/authController.dart';
import '../../controller/commanController.dart';
import '../../controller/splashController.dart';
import '../../controller/statusController.dart';
import '../../utils/showLogoutDialog.dart';
import '../callHistory/callHistory.dart';
import '../groupPage/groupPage.dart';
import 'widget/chatsPage.dart';
import 'widget/mytabbar.dart';

class HomePageScreen extends StatefulWidget {
  HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _textScaleAnimation; // Animation for title bounce

  Splashcontroller splashController = Get.put(Splashcontroller());
  AuthController authController = Get.put(AuthController());
  StatusController statuscontroller = Get.put(StatusController());
  @override
  void initState() {
    super.initState();
    Get.lazyPut(() => Commancontroller());

    // Animation Controller for rotation (Image) & bounce (Text)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Faster, smoother rotation
    )..repeat(); // Reversing for a natural feel

    // Text Bounce Animation
    _textScaleAnimation = Tween<double>(
      begin: 1.0, // Normal size
      end: 1.08, // Slightly bigger
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut, // Smooth in-out effect
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose animation when not needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 3, // Adds depth
          leading: Padding(
            padding: const EdgeInsets.all(10),
            child: RotationTransition(
              turns: _controller, // Smooth Rotation Effect
              child: Image.asset(
                AssetsImages.homeIconPng,
                height: 30, // Optimized size
              ),
            ),
          ),
          title: ScaleTransition(
            scale: _textScaleAnimation, // Text bounce effect
            child: const Text(
              "SAMPRAK",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2, // Adds spacing for better readability
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search, size: 26),
              onPressed: () {
                Chatcontroller().getChatRoomList();
              },
            ),
            PopupMenuButton<int>(
              icon: const Icon(Icons.more_vert_outlined),
              onSelected: (value) {
                if (value == 1) {
                  Get.toNamed("/profilePage");
                } else if (value == 2) {
                  print("Settings clicked");
                } else if (value == 3) {
                  showLogoutDialog(context); // Call the function correctly

                  print(
                      "authController.signout()====${authController.signout()}");
                  print("Logged out");
                }
              },
              itemBuilder: (BuildContext context) => [
                _buildPopupMenuItem(1, Icons.person, "Profile"),
                _buildPopupMenuItem(2, Icons.settings, "Settings"),
                _buildPopupMenuItem(3, Icons.logout, "Logout"),
              ],
            ),
          ],
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          bottom: mytabbar(),
        ),
        floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Custom shape
          ),
          backgroundColor: Colors.blue.shade700,
          onPressed: () {
            Get.toNamed("/contactPage");
          },
          child: const Icon(Icons.add, color: Colors.white, size: 30),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
              child: Chatspage(),
            ),
            Center(child: Grouppage()),
            Center(
              child: Callhistory()
            ),
          ],
        ),
      ),
    );
  }

  // Helper function for Popup Menu
  PopupMenuItem<int> _buildPopupMenuItem(
      int value, IconData icon, String text) {
    return PopupMenuItem<int>(
      value: value,
      child: Row(
        children: [
          Icon(icon, color: const Color.fromARGB(255, 255, 255, 255)),
          const SizedBox(width: 3),
          Text(text, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
