import 'package:chatapp/config/images.dart';
import 'package:chatapp/model/userModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/profileController.dart';
import 'widget/AboutContainer.dart';
import 'widget/Mediacotainer.dart';
import 'widget/GroupMwmberaddUserinfo.dart';

class UserprofileScreen extends StatelessWidget {
  UserModel? userModel;
  UserprofileScreen({super.key, this.userModel});

  List<String> images = [
    "https://images.pexels.com/photos/175695/pexels-photo-175695.jpeg",
    "https://images.pexels.com/photos/320184/pexels-photo-320184.jpeg",
    "https://images.pexels.com/photos/573306/pexels-photo-573306.jpeg",
    "https://images.pexels.com/photos/566031/pexels-photo-566031.jpeg",
    "https://images.pexels.com/photos/1386604/pexels-photo-1386604.jpeg",
    "https://images.pexels.com/photos/1308881/pexels-photo-1308881.jpeg",
    "https://images.pexels.com/photos/1391498/pexels-photo-1391498.jpeg",
    "https://images.pexels.com/photos/341970/pexels-photo-341970.jpeg",
    "https://images.pexels.com/photos/1468379/pexels-photo-1468379.jpeg"
  ];

  ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text('Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(); // Navigate back
          },
        ),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.edit),
        //     onPressed: () {
        //       profileController.fetchCurrentUser();
        //       Get.toNamed("/profilePage");
        //     },
        //   )
        // ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserInfo(
            profileImage:
                userModel?.profileImage ?? "https://picsum.photos/200/300",
            userName: userModel?.name ?? "Unknown User",
            userEmail: userModel?.email ?? "No Email Available",
          ),
          Mediacotainer(images: images),
          AboutContainer(),
        ],
      ),
    );
  }
}
