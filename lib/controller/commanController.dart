import 'package:get/get.dart';

class Commancontroller extends GetxController {
  RxBool isLogin = true.obs;
  void toggleForm() {
    isLogin.value = !isLogin.value; // Toggle between login and signup
  }
}
