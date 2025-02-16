import 'package:get/get.dart';

class Detailscontroller extends GetxController {
   var istrue = false.obs; // This makes it reactive
  var name = "".obs;
  var image = "".obs;
  var message = "".obs;

  void setChatDetails(
      {required String newName,
      required String? newImage,
      required String? newMessage}) {
    name.value = newName;
    image.value = newImage!;
    message.value = newMessage!;
  }
}
