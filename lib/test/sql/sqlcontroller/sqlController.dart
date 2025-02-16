import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../sqldb/dbhelper.dart';

class Sqlcontroller extends GetxController {
  DBHelper dbHelper = DBHelper();

  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  var userdata =
      <Map<String, dynamic>>[].obs; // Ensure this is initialized as a list
  var isloading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData(); // Load user data when the controller is initialized
  }

  Future<void> addUserData(String name, String username, String mobile) async {
    final user = {
      'name': name,
      'username': username,
      'mobile': mobile,
    };

    await dbHelper.insertData(user);
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final usersdata = await dbHelper.fetallData();
    userdata.assignAll(usersdata); // Update the list of users in the controller
  }
}
