import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/contColors.dart';
import '../../../config/images.dart';
import '../../../controller/profileController.dart';
import '../../../utils/zoomImage.dart';

class UserInfo extends StatelessWidget {
  final String? profileImage;
  final String? userName;
  final String? userEmail;

  UserInfo({
    super.key,
    this.profileImage,
    this.userName,
    this.userEmail,
  });

  ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        height: Get.height * 0.31,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.01,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ZoomedImageScreen(
                      imageUrl: profileImage ?? 'https://picsum.photos/200/300',
                    ),
                  ),
                );
              },
              child: Hero(
                tag: 'profileImage',
                child: CircleAvatar(
                  radius: 55,
                  backgroundImage: NetworkImage(
                    profileImage ?? 'https://picsum.photos/200/300',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Text(userName ?? "name"),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Text(userEmail ?? "email"),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: Get.height * 0.05,
                  width: Get.width * 0.25,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: Get.width * 0.012,
                        ),
                        Icon(Icons.call,
                            color: const Color.fromARGB(255, 80, 248, 2)),
                        SizedBox(
                          width: Get.width * 0.02,
                        ),
                        Text("Call",
                            style: TextStyle(
                                color: const Color.fromARGB(255, 80, 248, 2),
                                fontSize: 18)),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: Get.height * 0.05,
                  width: Get.width * 0.25,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: Get.width * 0.01,
                        ),
                        Image.asset(
                          AssetsImages.appiconPng,
                          height: 25,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Chat",
                            style: TextStyle(
                                color: const Color.fromARGB(255, 13, 222, 236),
                                fontSize: 18)),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: Get.height * 0.05,
                  width: Get.width * 0.25,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.video_call,
                          color: Contcolors.textColorOrange,
                          size: 30,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Chat",
                            style: TextStyle(
                                color: Contcolors.textColorOrange,
                                fontSize: 18)),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
