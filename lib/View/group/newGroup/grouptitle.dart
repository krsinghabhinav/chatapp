import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/View/group/newGroup/chattilelsit.dart';
import 'package:chatapp/controller/groupController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/showImageBottomsheet.dart';
import '../../../controller/imagePickerController.dart';
import '../../../controller/profileController.dart';

class Grouptitle extends StatefulWidget {
  const Grouptitle({super.key});

  @override
  State<Grouptitle> createState() => _GrouptitleState();
}

class _GrouptitleState extends State<Grouptitle> {
  Groupcontroller groupcontroller = Get.put(Groupcontroller());
  final ProfileController profileController = Get.put(ProfileController());
  final ImagePickerController imagepickercontroller =
      Get.put(ImagePickerController());
  RxString groupname = ''.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Group'),
      ),
      floatingActionButton: Obx(
        () => FloatingActionButton(
          backgroundColor: groupname.isEmpty ? Colors.grey : Colors.blue,
          onPressed: () {
            if (groupname.isEmpty) {
              Get.snackbar('Empty', "Please Enter Group Name");
              print(
                  "groupcontroller.groupNameController.text===${groupcontroller.groupNameController.text}");
            } else {
              groupcontroller.createGroup(
                  groupcontroller.groupNameController.text,
                  imagepickercontroller.pickedImage.value);
            }
          },
          child: groupcontroller.isLoading.value
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : const Icon(
                  Icons.done,
                  color: Colors.white,
                ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      showImageSourceBottomSheet(
                          context, imagepickercontroller.pickImage);
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 71, 71, 71),
                      ),
                      child: Obx(() {
                        String imagePath =
                            imagepickercontroller.pickedImage.value;
                        return imagePath.isEmpty
                            ? Icon(Icons.group, size: 40, color: Colors.white)
                            : ClipOval(
                                child: Image.file(
                                  File(imagePath),
                                  fit: BoxFit.cover,
                                  width: 80,
                                  height: 80,
                                ),
                              );
                      }),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) {
                        groupname.value = value;
                      },
                      controller: groupcontroller.groupNameController,
                      decoration: InputDecoration(
                        labelText: 'Group Name',
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                  children: groupcontroller.groupMembers
                      .map((e) => Card(
                            color: Colors.transparent,
                            elevation: 0,
                            child: SizedBox(
                              height: 68,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 0),
                                    child: Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          print("Tapped on Profile Image");
                                        },
                                        child: Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: const Color.fromARGB(
                                                255, 71, 71, 71),
                                            image: DecorationImage(
                                              image: e.profileImage!.isNotEmpty
                                                  ? CachedNetworkImageProvider(
                                                      e.profileImage!)
                                                  : const NetworkImage(
                                                      'https://picsum.photos/200/300'),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        // child: CircleAvatar(
                                        //   radius: 28,
                                        //   backgroundColor: const Color.fromARGB(
                                        //       255, 49, 49, 49),
                                        //   backgroundImage: NetworkImage(contact
                                        //           .profileImage ??
                                        //       'https://picsum.photos/200/300'),
                                        //   child: contact.profileImage == null
                                        //       ? const Icon(Icons.person,
                                        //           size: 28, color: Colors.grey)
                                        //       : null,
                                        // ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  e.name ?? "Unknown",
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              // Text(
                                              //   contact. ?? "N/A",
                                              //   style: const TextStyle(fontSize: 14, color: Colors.grey),
                                              // ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 12, right: 0),
                                          child: Row(
                                            children: [
                                              Text(
                                                e.email ??
                                                    "No status available",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .toList())
            ],
          ),
        ),
      ),
    );
  }
}
