// import 'package:chatapp/config/images.dart';
// import 'package:chatapp/controller/chatController.dart';
// import 'package:chatapp/model/chatmodel.dart';
// import 'package:chatapp/model/userModel.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../controller/DetailsController.dart';
// import 'widgets/chatBubble.dart';

// class ChatpageDetails extends StatelessWidget {
//   final UserModel? userModel;

//   ChatpageDetails({required this.userModel, super.key});

//   final Detailscontroller detailscontroller = Get.find<Detailscontroller>();
//   final Chatcontroller chatcontroller = Get.put(Chatcontroller());
//   final TextEditingController messageController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//       },
//       child: Scaffold(
//         resizeToAvoidBottomInset: true,
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           backgroundColor: Theme.of(context).colorScheme.primaryContainer,
//           title: Row(
//             children: [
//               IconButton(
//                 onPressed: () {
//                   Get.back();
//                 },
//                 icon: const Icon(Icons.arrow_back_ios),
//               ),
//               Obx(() => Container(
//                     width: 40,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       image: DecorationImage(
//                         image: detailscontroller.image.value.isNotEmpty
//                             ? NetworkImage(detailscontroller.image.value)
//                             : const NetworkImage(
//                                 'https://picsum.photos/200/300'),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   )),
//               const SizedBox(width: 10),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Obx(() => Text(
//                         detailscontroller.name.value.isNotEmpty
//                             ? detailscontroller.name.value
//                             : "User",
//                         style: const TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                       )),
//                   const Text(
//                     "online",
//                     style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           actions: const [
//             Icon(Icons.phone),
//             SizedBox(width: 15),
//             Icon(Icons.video_call),
//             SizedBox(width: 15),
//           ],
//         ),
//         body: Column(
//           children: [
//             SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),

//                 child: StreamBuilder<List<Chatmodel>>(
//                   stream: chatcontroller.getMessages(
//                     userModel!.id!,
//                   ),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(child: CircularProgressIndicator());
//                     }
//                     if (snapshot.hasError) {
//                       return Center(child: Text("error== ${snapshot.error}"));
//                     }
//                     if (snapshot.hasData) {
//                       return Expanded(
//                         child: ListView.builder(
//                             itemCount: snapshot.data!.length,
//                             itemBuilder: (context, index) {
//                               var data = snapshot.data![index];
//                               return ChatBubble(
//                                 message: data.message.toString(),
//                                 imageUrl: data.imageUrl,
//                                 isComming: true,
//                               );
//                             }),
//                       );
//                     }
//                     return Container();
//                   },
//                 ),
//                 // child: Column(
//                 //   children: [
//                 // ChatBubble(
//                 //   message: "hiiii Kaise ho ",
//                 //   imageUrl: "",
//                 //   isComming: false,
//                 //   status: "read",
//                 //   time: "10.30PM",
//                 // ),
//                 // ChatBubble(
//                 //   message: "hiiii Kaise ho ",
//                 //   imageUrl: "",
//                 //   isComming: false,
//                 //   status: "read",
//                 //   time: "10.30PM",
//                 // ),
//                 // ChatBubble(
//                 //   message: "hiiii Kaise ho ",
//                 //   imageUrl:
//                 //       'https://img.freepik.com/free-photo/bright-neon-colors-shining-wild-chameleon_23-2151682784.jpg',
//                 //   isComming: true,
//                 //   status: "read",
//                 //   time: "10.30PM",
//                 // ),
//                 //   ],
//                 // ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(bottom: 10, left: 18, right: 18),
//               child: Container(
//                 height: 50,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(250),
//                   color: Theme.of(context).colorScheme.primaryContainer,
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8),
//                   child: Center(
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         const Icon(
//                           Icons.mic,
//                           size: 30,
//                           color: Colors.white,
//                         ),
//                         Expanded(
//                           child: TextField(
//                             controller: messageController,
//                             decoration: InputDecoration(
//                               hintText: "Type here...............",
//                               hintStyle: const TextStyle(color: Colors.white70),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(20),
//                                 borderSide: BorderSide.none,
//                               ),
//                               contentPadding: const EdgeInsets.symmetric(
//                                 horizontal: 5,
//                                 vertical: 5,
//                               ),
//                             ),
//                             style: const TextStyle(color: Colors.white),
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             // Add gallery functionality here
//                           },
//                           icon: const Icon(
//                             Icons.photo_library,
//                             size: 25,
//                             color: Colors.white,
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             if (messageController.text.isNotEmpty &&
//                                 userModel != null) {
//                               chatcontroller.sendMessage(
//                                 userModel!.id!,
//                                 messageController.text,
//                               );
//                               print("userModel!.id!===${userModel!.id!}");
//                               print(
//                                   "messageController.text!===${messageController.text}");
//                               print(
//                                   "userModel!.name.===${userModel!.name.toString()}");
//                               messageController.clear();
//                             }
//                           },
//                           icon: const Icon(
//                             Icons.send,
//                             size: 25,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/View/UserProfile/userprofile_screen.dart';
import 'package:chatapp/controller/chatController.dart';
import 'package:chatapp/controller/DetailsController.dart';
import 'package:chatapp/model/chatmodel.dart';
import 'package:chatapp/model/userModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';

import '../../controller/imagePickerController.dart';
import '../../controller/profileController.dart';
import 'widgets/chatBubble.dart';
import 'widgets/typingbutton.dart';

class ChatpageDetails extends StatelessWidget {
  final UserModel? userModel;

  ChatpageDetails({required this.userModel, super.key});
  ProfileController profileController = Get.put(ProfileController());

  final Detailscontroller detailscontroller = Get.find<Detailscontroller>();
  final Chatcontroller chatcontroller = Get.put(Chatcontroller());
  final TextEditingController messageController = TextEditingController();
  final ImagePickerController imagePickerController =
      Get.put(ImagePickerController());

  RxBool isTyping = false.obs;
  RxBool showEmojiPicker = false.obs;
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          title: Row(
            children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back_ios),
              ),
              Obx(
                () => GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.33,
                            child: PhotoView(
                              imageProvider: detailscontroller.image.isNotEmpty
                                  ? CachedNetworkImageProvider(
                                      detailscontroller.image.value)
                                  : const NetworkImage(
                                      'https://picsum.photos/200/300'),
                              minScale: PhotoViewComputedScale.contained,
                              maxScale: PhotoViewComputedScale.covered * 2,
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: detailscontroller.image.value.isNotEmpty
                            ? CachedNetworkImageProvider(
                                detailscontroller.image.value)
                            : const NetworkImage(
                                'https://picsum.photos/200/300'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  Get.to(UserprofileScreen(
                    userModel: userModel,
                  ));
                },
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => Text(
                              detailscontroller.name.value.isNotEmpty
                                  ? detailscontroller.name.value
                                  : "User",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            )),
                        const Text(
                          "online",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: const [
            Icon(Icons.phone),
            SizedBox(width: 15),
            Icon(Icons.video_call),
            SizedBox(width: 15),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                  right: 8,
                ),
                child: Stack(children: [
                  StreamBuilder<List<Chatmodel>>(
                    stream: chatcontroller.getMessages(userModel!.id!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text("Error: ${snapshot.error}"));
                      }
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        return ListView.builder(
                          reverse: true, // Keep latest messages at the bottom
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            var data = snapshot.data![index];

                            // Convert timestamp to readable format
                            String formattedTime = "";
                            if (data.timestamp != null) {
                              DateTime dateTime = DateTime.parse(
                                  data.timestamp!); // Parse String to DateTime
                              formattedTime = DateFormat('hh:mm a')
                                  .format(dateTime); // Format as "10:30 PM"
                            }

                            return ChatBubble(
                              message: data.message.toString(),
                              imageUrl: data.imageUrl,
                              isComming: data.receiverId ==
                                      profileController.currentUser.value.id
                                  ? true
                                  : false,
                              time: formattedTime,
                              status: "read", // Pass formatted time
                            );
                          },
                        );
                      }
                      return const Center(child: Text("No messages yet"));
                    },
                  ),
                  Obx(
                    () => chatcontroller.selectedImagePath.value
                            .trim()
                            .isNotEmpty
                        ? Positioned(
                            bottom: 5,
                            left: 0,
                            right: 0,
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.file(
                                    File(
                                        chatcontroller.selectedImagePath.value),
                                    fit: BoxFit.contain,
                                    width: double.infinity,
                                    height: Get.height * 0.7,
                                  ),
                                ),
                                Positioned(
                                  right: 5,
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          chatcontroller
                                              .selectedImagePath.value = '';
                                        },
                                        child: Icon(
                                          Icons.close_rounded,
                                          color: Colors.white,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {},
                                        child: Icon(
                                          Icons.download,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SizedBox.shrink(),
                  )
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 2, left: 3, right: 3),
              child: typingbutton(
                messageController: messageController,
                focusNode: focusNode,
                isTyping: isTyping,
                chatcontroller: chatcontroller,
                userModel: userModel,
                imagepickercontroller: imagePickerController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
