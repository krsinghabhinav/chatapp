// import 'package:chatapp/model/userModel.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:get/get.dart';

// class Dbusergetcontroller extends GetxController {
//   final auth = FirebaseAuth.instance;
//   final db = FirebaseFirestore.instance;
//   var isLoading = false.obs;
//   var userList = <UserModel>[].obs;
//   // final RxList<UserModel> userList = <UserModel>[].obs;

//   Future<void> getUserList() async {
//     try {
//       isLoading.value = true;
//       String uid = auth.currentUser!.uid;

//       await db.collection('users').get().then((value) {
//         userList.value = value.docs
//             .map((e) => UserModel.fromMap(
//                   e.data(),
//                 ))
//             .toList();
//       });
//       isLoading.value = false;
//     } on Exception catch (e) {
//       isLoading.value = false;
//       print(e);
//     }
//   }
// @override
//   void onInit() {
//     getUserList();
//     super.onInit();
//   }
// }

import 'package:chatapp/model/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class DbUserGetController extends GetxController {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  var isLoading = false.obs;
  var userList = <UserModel>[].obs;

  Future<void> getUserList() async {
    try {
      isLoading.value = true;

      var snapshot = await db.collection('users').get();

      if (snapshot.docs.isEmpty) {
        Get.snackbar(
          "No Users Found",
          "There are no users in the database.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.errorContainer,
          colorText: Get.theme.colorScheme.onErrorContainer,
        );
      } else {
        userList.value =
            snapshot.docs.map((e) => UserModel.fromJson(e.data())).toList();

        Get.snackbar(
          "Success",
          "User list loaded successfully.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.primaryContainer,
          colorText: Get.theme.colorScheme.onPrimaryContainer,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to fetch user list: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    getUserList();
    super.onInit();
  }
}
