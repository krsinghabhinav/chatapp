import 'dart:io';

import 'package:chatapp/model/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class ProfileController extends GetxController {
  var isloading = false.obs;
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final store = FirebaseStorage.instance;
  var isEdit = false.obs;
  var currentUser = UserModel().obs;

  // Fetch current user from Firestore
  Future<void> fetchCurrentUser() async {
    String uid = auth.currentUser!.uid;
    await db.collection("users").doc(uid).get().then((value) {
      currentUser.value = UserModel.fromJson(value.data()!);
    });
  }

// Function to upload image to Firebase Storage
  Future<String?> uploadImageToFirebaseStorage(String imagePath) async {
    try {
      var uuid = Uuid();
      String uniqueFileName = "${uuid.v4()}.jpg"; // Generate unique file name
      final path = "profile_images/$uniqueFileName"; // Firebase Storage path
      final file = File(imagePath); // File object from the picked image
      final ref = store.ref().child(path); // Firebase Storage reference

      // Upload the file to Firebase Storage
      await ref.putFile(file);

      // Get and return the URL of the uploaded image
      return await ref.getDownloadURL();
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

// Function to update profile information
  Future<void> updateProfile(
    String? imageUrl,
    String? name,
    String? about,
    String? phoneNumber,
  ) async {
    try {
      isloading.value = true;
      String? imageUrlToSave;

      // Upload image if provided
      if (imageUrl != null && imageUrl.isNotEmpty) {
        imageUrlToSave = await uploadImageToFirebaseStorage(imageUrl);
      }
      print("imageUrlToSave=====${imageUrlToSave}");
      // Update Firestore with the new profile data
      String uid = auth.currentUser!.uid;

      await db.collection("users").doc(uid).update({
        'name': name,
        'about': about,
        'phoneNumber': phoneNumber,
        'email': currentUser.value.email,
        if (imageUrlToSave != null) 'profileImage': imageUrlToSave,
      });

      // After Firestore update, update the local currentUser to reflect the changes
      currentUser.value = UserModel(
        name: name,
        about: about,
        phoneNumber: phoneNumber,
        profileImage: imageUrlToSave,
        email: currentUser.value.email,
      );

      isloading.value = false;
      print("Profile updated successfully!");

      // Show success Snackbar
      Get.showSnackbar(
        GetSnackBar(
          title: "Success",
          message: "Profile updated successfully!",
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM,
          borderRadius: 10,
          margin: EdgeInsets.all(10),
        ),
      );
    } catch (e) {
      isloading.value = false;
      print("Error updating profile: $e");

      // Show error Snackbar
      Get.showSnackbar(
        GetSnackBar(
          title: "Error",
          message: "Failed to update profile: $e",
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          borderRadius: 10,
          margin: EdgeInsets.all(10),
        ),
      );
    }
  }

  // // Update the profile information
  // Future<void> updateProfile(
  //   String? imageUrl,
  //   String? name,
  //   String? about,
  //   String? phoneNumber,
  // ) async {
  //   try {
  //     isloading.value = true;
  //     String? imageUrlToSave;

  //     // Upload image if provided
  //     if (imageUrl != null && imageUrl.isNotEmpty) {
  //       var uuid = Uuid();
  //       String uniqueFileName = "${uuid.v4()}.jpg"; // Generate unique file name
  //       final path = "profile_images/$uniqueFileName"; // Firebase Storage path
  //       final file = File(imageUrl); // File object from the picked image
  //       final ref = store.ref().child(path); // Firebase Storage reference

  //       // Upload the file to Firebase Storage
  //       await ref.putFile(file);
  //       imageUrlToSave =
  //           await ref.getDownloadURL(); // Get the URL of the uploaded image
  //     }

  //     // Update Firestore with the new profile data
  //     String uid = auth.currentUser!.uid;

  //     await db.collection("users").doc(uid).update({
  //       'name': name,
  //       'about': about,
  //       'phoneNumber': phoneNumber,
  //       'email': currentUser.value.email,
  //       if (imageUrlToSave != null) 'profileImage': imageUrlToSave,
  //     });

  //     // After Firestore update, update the local currentUser to reflect the changes
  //     currentUser.value = UserModel(
  //       name: name,
  //       about: about,
  //       phoneNumber: phoneNumber,
  //       profileImage: imageUrlToSave,
  //       email: currentUser.value.email,
  //     );

  //     isloading.value = false;
  //     print("Profile updated successfully!");
  //     // Show Snackbar at the top with instant feedback
  //     Get.showSnackbar(
  //       GetSnackBar(
  //         title: "Success",
  //         message: "Profile updated successfully!",
  //         duration: Duration(seconds: 2),
  //         backgroundColor: Colors.green,
  //         snackPosition: SnackPosition.BOTTOM,
  //         borderRadius: 10,
  //         margin: EdgeInsets.all(10),
  //       ),
  //     );
  //   } catch (e) {
  //     isloading.value = false;
  //     print("Error uploading file: $e");
  //     // Show Error Snackbar at the top instantly
  //     Get.showSnackbar(
  //       GetSnackBar(
  //         title: "Error",
  //         message: "Failed to update profile: $e",
  //         duration: Duration(seconds: 3),
  //         backgroundColor: Colors.red,
  //         snackPosition: SnackPosition.BOTTOM,
  //         borderRadius: 10,
  //         margin: EdgeInsets.all(10),
  //       ),
  //     );
  //   }
  // }

  @override
  void onInit() async {
    await fetchCurrentUser();
    super.onInit();
  }
}
