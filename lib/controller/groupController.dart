import 'package:chatapp/View/home/HomePageScreen.dart';
import 'package:chatapp/controller/profileController.dart';
import 'package:chatapp/model/groupModel.dart';
import 'package:chatapp/model/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class Groupcontroller extends GetxController {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  var uuid = Uuid();
  ProfileController profileController = Get.put(ProfileController());
  TextEditingController groupNameController = TextEditingController();
  var isLoading = false.obs;

  var groupList = <GroupModel>[].obs;
  var groupMembers = <UserModel>[].obs;

  void selectMember(UserModel user) {
    if (groupMembers.contains(user)) {
      groupMembers.remove(user);
    } else {
      groupMembers.add(user);
    }
  }

  Future<void> createGroup(String groupName, String imagePath) async {
    isLoading.value = true;
    String groupId = uuid.v4();
    String? imageUrl;
    try {
      // Agar image path diya gaya hai, to Firebase par upload karo
      if (imagePath.isNotEmpty) {
        imageUrl =
            await profileController.uploadImageToFirebaseStorage(imagePath);
      }
      print("create group imageurl=== ${imageUrl}");
      print(
          "create groupMembers.toList() imageurl=== ${groupMembers.toList()}");

      // GroupModel ka instance banao
      var newGroup = GroupModel(
        id: groupId,
        name: groupName,
        profileUrl: imageUrl, // Jo bhi image upload hui ho, wo set ho jayegi
        members: groupMembers.toList(),
        createdAt: DateTime.now().toIso8601String(),
        createBy: auth.currentUser!.uid,
        timeStamp: DateTime.now().toIso8601String(),
      );

      // Firebase ya kisi database me store karo (Agar required ho)
      await db.collection('groups').doc(groupId).set(newGroup.toJson());
      Get.offAll(HomePageScreen());
      Get.snackbar('Group Created', "Group Created Successfully");
      print("groupcontroller.groupNameController.text===${groupName}");
      print("groupcontroller.groupMembers.toList()===${groupMembers.toList()}");
      isLoading.value = false;
    } on Exception catch (e) {
      isLoading.value = false;
      print('Error: $e');
    }
  }

  // Future<void> createGroup(String groupName, String imagePath) async {
  //   String groupId = uuid.v4();
  //   if (imagePath.isNotEmpty) {
  //     String? imageUrl =
  //         await profileController.uploadImageToFirebaseStorage(imagePath);
  //     var newGroup = GroupModel(
  //       id: groupId,
  //       name: groupName,
  //     );
  //   } else {
  //     var newGroup = GroupModel(
  //       id: groupId,
  //       name: groupName,
  //       profileUrl: imagePath,
  //     );
  //   }
  // }

  Future<void> getGroup() async {
    isLoading(true);
    List<GroupModel> tempGroup = [];
    await db.collection('groups').get().then((value) {
      tempGroup =
          value.docs.map((doc) => GroupModel.fromJson(doc.data())).toList();
    });
    groupList.clear();
    groupList.value = tempGroup
        .where((e) =>
            e.members!.any((element) => element.id == auth.currentUser!.uid))
        .toList();
    isLoading(false);
  }
}
