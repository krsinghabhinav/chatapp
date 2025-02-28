import 'package:chatapp/model/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Contactcontroller extends GetxController {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  var isLoading = false.obs;
  var userList = <UserModel>[].obs;
  var filterList = <UserModel>[].obs;

  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    getUserList();
    super.onInit();
    searchController
        .addListener(searchChanged); // Add listener for search field
  }

  // Fetch user list from Firestore
  Future<void> getUserList() async {
    try {
      isLoading.value = true;
      String uid = auth.currentUser!.uid;

      await db.collection('users').get().then((value) {
        userList.value =
            value.docs.map((e) => UserModel.fromJson(e.data())).toList();
      });

      // Set the filter list to user list initially
      filterList.value = userList;
      print("filterList.value===${filterList}");
      print("userList.value ==${userList}");
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print(e);
    }
  }

  // Filter search based on name and phone number
  void searchChanged() {
    String query = searchController.text.toLowerCase();

    // Filter the user list based on the search query
    filterList.value = userList.where((user) {
      return (user.name != null && user.name!.toLowerCase().contains(query)) ||
          (user.phoneNumber != null &&
              user.phoneNumber!.toLowerCase().contains(query));
    }).toList();
    print("query====${query}");
  }

  Future<void> saveContact(UserModel user) async {
    try {
      await db
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection("contacts")
          .doc(user.id)
          .set(user.toJson());
    } on Exception catch (e) {
      print("Error saving contact: $e");
    }
  }

  Stream<List<UserModel>> getContacts() {
    return db
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('contacts')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => UserModel.fromJson(doc.data()))
          .toList();
    });
  }
}
