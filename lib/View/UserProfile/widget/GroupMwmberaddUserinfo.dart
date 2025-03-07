import 'package:chatapp/controller/groupController.dart';
import 'package:chatapp/model/userModel.dart';
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
  final String? groupId;

  UserInfo({
    super.key,
    this.profileImage,
    this.userName,
    this.userEmail,
    this.groupId,
  });

  ProfileController profileController = Get.put(ProfileController());
  Groupcontroller groupController = Get.put(Groupcontroller());
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
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 1,
                        ),
                        Icon(
                          Icons.video_call,
                          color: Contcolors.textColorOrange,
                          size: 30,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text("Video",
                            style: TextStyle(
                                color: Contcolors.textColorOrange,
                                fontSize: 18)),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    var newMember = UserModel(
                      name: "girisha singh",
                      email: "gisu@gmail.com",
                      profileImage: "",
                      role: 'admin',
                    );

                    groupController.addGroupMember(groupId!, newMember);
                  },
                  child: Container(
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
                            width: 2,
                          ),
                          Icon(
                            Icons.group_add,
                            color: Colors.white,
                            size: 25,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Add",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                        ],
                      ),
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
