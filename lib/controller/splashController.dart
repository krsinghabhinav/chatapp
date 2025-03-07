import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class Splashcontroller extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool hasNavigated = false; // Prevent duplicate navigation

  Future<void> splashHendler() async {
    User? currentUser = auth.currentUser;

    print("auth.currentUser== ${currentUser?.email ?? "No user logged in"}");

    await Future.delayed(Duration(seconds: 5), () {
      if (!hasNavigated) {
        // Ensure navigation happens only once
        hasNavigated = true;

        if (currentUser == null) {
          Get.offAllNamed("/welcomePage");
        } else {
          Get.offAllNamed("/homePage");
        }
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    splashHendler();
  }
}
