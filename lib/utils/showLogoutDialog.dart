import 'dart:ui';
import 'package:chatapp/config/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/authController.dart';

void showLogoutDialog(BuildContext context) {
  AuthController authController = Get.put(AuthController());

  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 10,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purpleAccent, Colors.deepPurple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      AssetsImages.appiconPng, // Ensure this path is correct
                      height: 70,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Confirm Logout",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Are you sure you want to logout?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          "Cancel",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          Get.offAllNamed(
                              "/authPage"); // Ensure this route is valid
                          await authController.signout(); // Ensure it's awaited
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          "Logout",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: -50,
              left: 0,
              right: 0,
              child: CircleAvatar(
                backgroundColor:
                    const Color.fromARGB(255, 255, 255, 255).withOpacity(0.3),
                radius: 35,
                child: Icon(Icons.question_mark, size: 45, color: Colors.white),
              ),
            ),
          ],
        ),
      );
    },
  );
}
