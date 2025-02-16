import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class   ImagePickerController extends GetxController {
  var pickedImage = ''.obs;
  ImagePicker picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    final  image = await picker.pickImage(source: source);
    if (image != null) {
      pickedImage.value = image.path; // Updates the selected image
      print("imagepath==== >${pickedImage.value}");
    }
  }
}
