import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/showImageBottomsheet.dart';
import '../../controller/authController.dart';
import '../../controller/imagePickerController.dart';
import '../../controller/profileController.dart';
import '../../utils/showLogoutDialog.dart';
import '../../widgets/commonButton.dart';

class ProfilepageScreen extends StatelessWidget {
  ProfilepageScreen({super.key});
  final ProfileController profileController = Get.put(ProfileController());
  final ImagePickerController imagepickercontroller =
      Get.put(ImagePickerController());
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController aboutController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text('Profile'),
        actions: [
          IconButton(
            onPressed: () {
              showLogoutDialog(context); // Call the function correctly
            },
            icon: Icon(Icons.logout),
          ),
          SizedBox(
            width: 5,
          )
        ],
      ),
      body: Obx(() {
        nameController.text = profileController.currentUser.value.name ?? "";
        aboutController.text = profileController.currentUser.value.about ?? "";
        emailController.text = profileController.currentUser.value.email ?? "";
        phoneController.text =
            profileController.currentUser.value.phoneNumber ?? "";

        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: Get.height * 0.02),
                      Stack(
                        children: [
                          Obx(
                            () => CircleAvatar(
                              radius: 65,
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.white,
                              child: Container(
                                width: Get.width * 0.4, // Diameter (2 * radius)
                                height:
                                    Get.height * 0.16, // Diameter (2 * radius)
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: imagepickercontroller
                                            .pickedImage.value.isNotEmpty
                                        ? FileImage(File(imagepickercontroller
                                            .pickedImage.value))
                                        : CachedNetworkImageProvider(
                                            profileController.currentUser.value
                                                    .profileImage ??
                                                'https://picsum.photos/200/300',
                                          ) as ImageProvider,
                                    fit: BoxFit
                                        .fill, // Ensures the image fills the entire circle
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Obx(() => Positioned(
                                right: Get.height * 0.02,
                                top: Get.height * 0.11,
                                child: profileController.isEdit.value
                                    ? GestureDetector(
                                        onTap: () {
                                          showImageSourceBottomSheet(context,
                                              imagepickercontroller.pickImage);
                                        },
                                        child: Container(
                                          height: Get.height * 0.05,
                                          width: Get.width * 0.11,
                                          decoration: BoxDecoration(
                                            color: Colors.amber,
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.image_rounded,
                                              color: Colors.white,
                                              size: 28,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ))
                        ],
                      ),
                      SizedBox(height: Get.height * 0.02),
                      Obx(() => TextField(
                            controller: nameController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                labelText: 'Name',
                                hintText: 'Name',
                                enabled: profileController.isEdit.value,
                                filled: profileController.isEdit.value,
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                )),
                          )),
                      SizedBox(height: Get.height * 0.02),
                      Obx(() => TextField(
                            controller: aboutController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                labelText: 'About',
                                hintText: 'About',
                                enabled: profileController.isEdit.value,
                                filled: profileController.isEdit.value,
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.info_rounded,
                                  color: Colors.white,
                                )),
                          )),
                      SizedBox(height: Get.height * 0.02),
                      TextField(
                        controller: emailController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'Email',
                            enabled: false,
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.alternate_email_sharp,
                              color: Colors.white,
                            )),
                      ),
                      SizedBox(height: Get.height * 0.02),
                      Obx(() => TextField(
                            controller: phoneController,
                            maxLength: 10,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Number',
                              hintText: 'Number',
                              enabled: profileController.isEdit.value,
                              filled: profileController.isEdit.value,
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.call,
                                color: Colors.white,
                              ),
                            ),
                          )),
                      SizedBox(height: Get.height * 0.02),
                      Obx(
                        () => profileController.isloading.value
                            ? CircularProgressIndicator()
                            : profileController.isEdit.value
                                ? CommonButton(
                                    icon: Icons.save,
                                    btnName: "Save",
                                    onTap: () {
                                      profileController.isEdit.value = false;
                                      // Trigger the updateProfile function with all values, including the picked image
                                      profileController.updateProfile(
                                          imagepickercontroller
                                              .pickedImage.value,
                                          nameController.text,
                                          aboutController.text,
                                          phoneController
                                              .text); // Set to false after saving
                                    },
                                    color:
                                        const Color.fromARGB(255, 4, 142, 255),
                                  )
                                : CommonButton(
                                    icon: Icons.edit,
                                    btnName: "Edit",
                                    onTap: () {
                                      profileController.isEdit.value =
                                          true; // Set to true to enable editing
                                    },
                                    color:
                                        const Color.fromARGB(255, 4, 142, 255),
                                  ),
                      ),
                      SizedBox(height: Get.height * 0.02),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
