import 'package:chatapp/View/welcome/welcomepage.dart';
import 'package:chatapp/model/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'commanController.dart';

class AuthController extends GetxController {
  var fullnameController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  bool hasNavigated = false; // Prevent duplicate navigation
  final db = FirebaseFirestore.instance;
  var isloading = false.obs;
  final Commancontroller commonController =
      Get.find(); // Get CommonController instance

  Future<void> createUser() async {
    try {
      isloading.value = true; // Start loading

      String fullname = fullnameController.value.text.trim();
      String email = emailController.value.text.trim();
      String password = passwordController.value.text.trim();

      if (fullname.isEmpty || email.isEmpty || password.isEmpty) {
        isloading.value = false; // Reset loading
        Get.snackbar('Error', 'Please fill all fields',
            backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
        return;
      }

      if (!GetUtils.isEmail(email)) {
        isloading.value = false;
        Get.snackbar('Error', 'Invalid email format',
            backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
        return;
      }

      if (password.length < 6) {
        isloading.value = false;
        Get.snackbar('Error', 'Password must be at least 6 characters long',
            backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
        return;
      }

      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await initUserData(email, fullname);
      // Clear text fields only after success
      fullnameController.value.clear();
      emailController.value.clear();
      passwordController.value.clear();
      // Switch to LoginForm
      commonController.toggleForm();
      Get.snackbar('Success', 'Registration successful',
          backgroundColor: Colors.green, snackPosition: SnackPosition.BOTTOM);
      // Get.offAllNamed("/login");
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', _handleAuthError(e.code),
          backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred: $e',
          backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
    } finally {
      isloading.value = false; // Always stop loading
    }
  }

  Future<void> login() async {
    try {
      isloading.value = true; // Start loading

      String email = emailController.value.text.trim();
      String password = passwordController.value.text.trim();

      if (email.isEmpty || password.isEmpty) {
        isloading.value = false; // Reset loading
        Get.snackbar('Error', 'Please fill all fields',
            backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
        return;
      }

      if (!GetUtils.isEmail(email)) {
        isloading.value = false;
        Get.snackbar('Error', 'Invalid email format',
            backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
        return;
      }

      await auth.signInWithEmailAndPassword(email: email, password: password);

      // Clear text fields only after success
      emailController.value.clear();
      passwordController.value.clear();

      Get.offAllNamed("/homePage");
      Get.snackbar('Success', 'Login successful',
          backgroundColor: Colors.green, snackPosition: SnackPosition.BOTTOM);
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', _loginAuthError(e.code),
          backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred: $e',
          backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
    } finally {
      isloading.value = false; // Always stop loading
    }
  }

  // Separate function for handling Firebase authentication errors
  String _handleAuthError(String errorCode) {
    switch (errorCode) {
      case 'email-already-in-use':
        return 'This email is already registered. Try logging in.';
      case 'invalid-email':
        return 'Invalid email format.';
      case 'weak-password':
        return 'Password is too weak. Try a stronger one.';
      default:
        return 'Registration failed. Please try again.';
    }
  }

  String _loginAuthError(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'invalid-email':
        return 'Invalid email format.';
      default:
        return 'Login failed. Please try again.';
    }
  }

  Future<void> signout() async {
    try {
      await auth.signOut();

      // Redirect to authentication page
      if (!hasNavigated) {
        // Ensure navigation happens only once
        hasNavigated = true;

        Get.offAllNamed("/authPage");
        print('User successfully logged out.');
        Get.snackbar("Logout", "User successfully logged out.",
            backgroundColor: Colors.green, snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print("Logout failed: $e");
      Get.snackbar("Error", "Failed to logout. Please try again.",
          backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> initUserData(String email, String fname) async {
    try {
      String uid = auth.currentUser!.uid; // Ensure user ID is retrieved

      UserModel user = UserModel(
          id: uid,
          email: email,
          name: fname,
          createdAt: DateTime.now().toIso8601String());

      await db.collection("users").doc(uid).set(user.toJson());

      print("User data initialized successfully");
    } on Exception catch (e) {
      print("Error initializing user data: $e");
    }
  }
}
