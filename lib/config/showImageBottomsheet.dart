import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

 showImageSourceBottomSheet(BuildContext context, Function(ImageSource) pickImage) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Choose Image Source",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.blue),
              title: const Text("Camera"),
              onTap: () {
                Get.back(); // Close bottom sheet
                pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo, color: Colors.green),
              title: const Text("Gallery"),
              onTap: () {
                Get.back(); // Close bottom sheet
                pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      );
    },
  );
}
