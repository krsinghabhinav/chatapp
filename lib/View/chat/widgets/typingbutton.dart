import 'package:chatapp/config/showImageBottomsheet.dart';
import 'package:chatapp/controller/imagePickerController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controller/chatController.dart';
import '../../../model/userModel.dart';

class typingbutton extends StatelessWidget {
  typingbutton({
    super.key,
    required this.messageController,
    required this.focusNode,
    required this.isTyping,
    required this.chatcontroller,
    required this.imagepickercontroller,
    required this.userModel,
  });

  final TextEditingController messageController;
  final FocusNode focusNode;
  final RxBool isTyping;
  final Chatcontroller chatcontroller;
  final UserModel? userModel;
  final ImagePickerController imagepickercontroller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2, left: 2, right: 2),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: 150, // Max height like WhatsApp
          minHeight: 50,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.emoji_emotions, size: 28, color: Colors.white),
              ),
              Expanded(
                child: TextField(
                  controller: messageController,
                  focusNode: focusNode,
                  maxLines: null, // Expands dynamically
                  minLines: 1,
                  keyboardType: TextInputType.multiline,
                  onChanged: (value) {
                    isTyping.value = value.trim().isNotEmpty;
                    chatcontroller.message.value = value;
                  },
                  decoration: InputDecoration(
                    hintText: "Type here...",
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              // Usage inside GestureDetector

              GestureDetector(
                onTap: () async {
                  print("📸 Image picker opened");

                  Get.bottomSheet(Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10)),
                    ),
                    height: 150,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () async {
                              Get.back();
                              await imagepickercontroller
                                  .pickImage(ImageSource.camera);
                              chatcontroller.selectedImagePath.value =
                                  imagepickercontroller.pickedImage.value;
                              print(
                                  "chatcontroller.selectedImagePath.value === ${chatcontroller.selectedImagePath.value}");
                              print(
                                  "imagepickercontroller.pickedImage.value === ${imagepickercontroller.pickedImage.value}");
                            },
                            child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  Icons.camera,
                                  size: 40,
                                )),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () async {
                              Get.back();
                              await imagepickercontroller
                                  .pickImage(ImageSource.gallery);
                              chatcontroller.c.value =
                                  imagepickercontroller.pickedImage.value;
                              print(
                                  "chatcontroller.selectedImagePath.value === ${chatcontroller.selectedImagePath.value}");
                              print(
                                  "imagepickercontroller.pickedImage.value === ${imagepickercontroller.pickedImage.value}");
                            },
                            child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  Icons.photo,
                                  size: 40,
                                )),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () async {
                              Get.back();
                            },
                            child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  Icons.play_arrow,
                                  size: 40,
                                )),
                          ),
                        )
                      ],
                    ),
                  ));
                  // await showImageSourceBottomSheet(context,
                  //     (ImageSource source) async {
                  //   await imagepickercontroller.pickImage(source);
                  //   print(
                  //       "🔍 Picked image path: ${imagepickercontroller.pickedImage.value}");

                  //   if (imagepickercontroller.pickedImage.value.isNotEmpty) {
                  //     chatcontroller.selectedImagePath.value =
                  //         imagepickercontroller.pickedImage.value;
                  //     print(
                  //         "✅ Image stored in selectedImagePath: ${chatcontroller.selectedImagePath.value}");
                  //   }
                  // });
                },
                child: Obx(() => Icon(
                      chatcontroller.selectedImagePath.value.isEmpty
                          ? Icons.photo_library
                          : Icons.image,
                      size: 28,
                      color: Colors.white,
                    )),
              ),

              Obx(() => (chatcontroller.message.value.trim().isNotEmpty ||
                      chatcontroller.selectedImagePath.value.isNotEmpty)
                  ? IconButton(
                      onPressed: () {
                        print("📤 Send button pressed");
                        print("✉️ Message: ${chatcontroller.message.value}");
                        print(
                            "🖼️ Image Path: ${chatcontroller.selectedImagePath.value}");

                        bool isTextNotEmpty =
                            chatcontroller.message.value.trim().isNotEmpty;
                        bool isImageNotEmpty =
                            chatcontroller.selectedImagePath.value.isNotEmpty;

                        if (isTextNotEmpty || isImageNotEmpty) {
                          chatcontroller.sendMessage(
                            userModel!.id!,
                            chatcontroller.message.value
                                .trim(), // Send only text if available
                            userModel!,
                          );

                          // ✅ Clear fields only after sending
                          print(
                              "🔄 Clearing message and image after sending...");
                          messageController.clear();
                          chatcontroller.message.value = "";
                          chatcontroller.selectedImagePath.value = "";
                          print(
                              "🖼️ Image Path: ${chatcontroller.selectedImagePath.value}");
                        }
                      },
                      icon: chatcontroller.isLoading.value
                          ? Center(
                              child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ))
                          : Icon(Icons.send, size: 28, color: Colors.white),
                    )
                  : IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.mic, size: 28, color: Colors.white),
                    )), // GestureDetector(
              //   onTap: () {
              //     print("Photo icon tapped!"); // Debugging log
              //     if (chatcontroller.selectedImagePath.value.isEmpty) {
              //       // Open bottom sheet to pick an image
              //       showImageSourceBottomSheet(context,
              //           (ImageSource source) async {
              //         await imagepickercontroller.pickImage(source);
              //         if (imagepickercontroller.pickedImage.value.isNotEmpty) {
              //           chatcontroller.selectedImagePath.value =
              //               imagepickercontroller.pickedImage.value;
              //           print(
              //               "Image selected: ${chatcontroller.selectedImagePath.value}");
              //         }
              //       });
              //     } else {
              //       showImageSourceBottomSheet(context,
              //           (ImageSource source) async {
              //         await imagepickercontroller.pickImage(source);
              //         if (imagepickercontroller.pickedImage.value.isNotEmpty) {
              //           chatcontroller.selectedImagePath.value =
              //               imagepickercontroller.pickedImage.value;
              //           print(
              //               "Image selected: ${chatcontroller.selectedImagePath.value}");
              //         }
              //       });
              //       // Clear the selected image
              //       // chatcontroller.selectedImagePath.value = "";
              //     }
              //   },
              //   child: Obx(() => Icon(
              //         chatcontroller.selectedImagePath.value.isEmpty
              //             ? Icons
              //                 .photo_library // Show photo library icon when image is selected
              //             : Icons
              //                 .photo_library, // Show add photo icon when no image is selected
              //         size: 28,
              //         color: Colors.white,
              //       )),
              // ),
              // Obx(() => (chatcontroller.message.value.trim().isNotEmpty ||
              //         chatcontroller.selectedImagePath.value.isNotEmpty)
              //     ? IconButton(
              //         onPressed: () {
              //           if (chatcontroller.message.value.trim().isNotEmpty ||
              //               chatcontroller.selectedImagePath.value.isNotEmpty) {
              //             chatcontroller.sendMessage(
              //               userModel!.id!,
              //               messageController.text.trim(),
              //               userModel!,
              //             );

              //             // Clear message input field only if text is sent
              //             messageController.clear();
              //             chatcontroller.message.value = "";

              //             // Clear image path only if an image is sent
              //             chatcontroller.selectedImagePath.value = "";
              //           }
              //         },
              //         icon: Icon(Icons.send, size: 28, color: Colors.white),
              //       )
              //     : IconButton(
              //         onPressed: () {},
              //         icon: Icon(Icons.mic, size: 28, color: Colors.white),
              //       )),

              // {
              // if (chatcontroller.message.trim().isEmpty ||
              //     chatcontroller.selectedImagePath.value.isEmpty) {
              //   // Show mic icon when both message and image are empty
              //   return IconButton(
              //     onPressed: () {},
              //     icon: Icon(Icons.mic, size: 28, color: Colors.white),
              //   );
              // } else {
              //   // Show send icon when either message or image is not empty
              //   return IconButton(
              //     onPressed: () {
              //       if (messageController.text.isNotEmpty ||
              //           chatcontroller.selectedImagePath.value.isNotEmpty) {
              //         chatcontroller.sendMessage(
              //             userModel!.id!,
              //             messageController.text,
              //             userModel!,
              //            );
              //         print("====================================");
              //         messageController.clear();
              //         chatcontroller.message.value = "";
              //         chatcontroller.selectedImagePath.value = "";
              //       }
              //     },
              //     icon: Icon(Icons.send, size: 28, color: Colors.white),
              //   );
              // }
              // }),

              //=> chatcontroller.message.value.trim().isEmpty ||
              //         chatcontroller.selectedImagePath.value.isEmpty
              //     ? IconButton(
              //         onPressed: () {},
              //         icon: Icon(Icons.mic, size: 28, color: Colors.white),
              //       )
              //     : IconButton(
              //         onPressed: () {
              //           if (messageController.text.isNotEmpty &&
              //               userModel != null) {
              //             chatcontroller.sendMessage(
              //               userModel!.id!,
              //               messageController.text,
              //               userModel!,
              //             );
              //             messageController.clear();
              //             chatcontroller.message.value = " ";
              //           }
              //         },
              // icon: Icon(Icons.send, size: 28, color: Colors.white),
              // ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
