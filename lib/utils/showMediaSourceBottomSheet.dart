import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:geolocator/geolocator.dart';

void showMediaSourceBottomSheet(
    BuildContext context, Function(ImageSource) pickImage, Function(FileType) pickFile, Function() pickLocation) {
    // BuildContext context, Function(ImageSource) pickImage, Function(FileType) pickFile, Function() pickLocation) {
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
              "Choose Media Source",
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
            ListTile(
              leading: const Icon(Icons.video_library, color: Colors.red),
              title: const Text("Pick Video"),
              onTap: () {
                Get.back(); // Close bottom sheet
                pickFile(FileType.video);
              },
            ),
            ListTile(
              leading: const Icon(Icons.insert_drive_file, color: Colors.orange),
              title: const Text("Pick Document"),
              onTap: () {
                Get.back(); // Close bottom sheet
                pickFile(FileType.any); // Allows any type of document
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_on, color: Colors.purple),
              title: const Text("Share Location"),
              onTap: () {
                Get.back(); // Close bottom sheet
                pickLocation();
              },
            ),
          ],
        ),
      );
    },
  );
  showMediaSourceBottomSheet(
  context, 
  (ImageSource source) async {
    // Handle image picking
  }, 
  (FileType fileType) async {
    // Handle document or video picking
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: fileType);
    if (result != null) {
      print("Selected File: ${result.files.single.path}");
    }
  },
  () async {
    // Handle location selection
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print("Location: ${position.latitude}, ${position.longitude}");
  }
);

}
