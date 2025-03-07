// import 'dart:io';

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:chatapp/View/UserProfile/userprofile_screen.dart';
// import 'package:chatapp/View/groupChate/group_type_message.dart';
// import 'package:chatapp/controller/chatController.dart';
// import 'package:chatapp/controller/DetailsController.dart';
// import 'package:chatapp/model/chatmodel.dart';
// import 'package:chatapp/model/groupModel.dart';
// import 'package:chatapp/model/userModel.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:photo_view/photo_view.dart';

// import '../../controller/imagePickerController.dart';
// import '../../controller/profileController.dart';
// import '../chat/widgets/chatBubble.dart';
// import '../chat/widgets/typingbutton.dart';

// class Groupchatepage extends StatelessWidget {
//   final GroupModel? groupModel;

//   Groupchatepage({required this.groupModel, super.key});
//   ProfileController profileController = Get.put(ProfileController());

//   final Detailscontroller detailscontroller = Get.find<Detailscontroller>();
//   final Chatcontroller chatcontroller = Get.put(Chatcontroller());
//   final TextEditingController messageController = TextEditingController();
//   final ImagePickerController imagePickerController =
//       Get.put(ImagePickerController());

//   RxBool isTyping = false.obs;
//   RxBool showEmojiPicker = false.obs;
//   FocusNode focusNode = FocusNode();
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         resizeToAvoidBottomInset: true,
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           backgroundColor: Theme.of(context).colorScheme.primaryContainer,
//           title: Row(
//             children: [
//               IconButton(
//                 onPressed: () => Get.back(),
//                 icon: const Icon(Icons.arrow_back_ios),
//               ),
//               Obx(
//                 () => GestureDetector(
//                   onTap: () {
//                     showDialog(
//                       context: context,
//                       builder: (context) {
//                         return Dialog(
//                           child: Container(
//                             width: MediaQuery.of(context).size.width * 0.9,
//                             height: MediaQuery.of(context).size.height * 0.33,
//                             child: PhotoView(
//                               imageProvider: groupModel!.profileUrl!.isNotEmpty
//                                   ? CachedNetworkImageProvider(
//                                       groupModel!.profileUrl!)
//                                   : const NetworkImage(
//                                       'https://picsum.photos/200/300'),
//                               minScale: PhotoViewComputedScale.contained,
//                               maxScale: PhotoViewComputedScale.covered * 2,
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                   child: Container(
//                     width: 40,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       image: DecorationImage(
//                         image: groupModel!.profileUrl!.isNotEmpty
//                             ? CachedNetworkImageProvider(
//                                 groupModel!.profileUrl!)
//                             : const NetworkImage(
//                                 'https://picsum.photos/200/300'),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 10),
//               GestureDetector(
//                 onTap: () {
//                   // Get.to(UserprofileScreen(
//                   //   userModel: userModel,
//                   // ));
//                 },
//                 child: Row(
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Obx(() => Text(
//                               groupModel!.name!.isNotEmpty
//                                   ? groupModel!.name!
//                                   : "User",
//                               style: const TextStyle(
//                                   fontSize: 16, fontWeight: FontWeight.bold),
//                             )),
//                         const Text(
//                           "online",
//                           style: TextStyle(
//                               fontSize: 12, fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
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
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.only(
//                   left: 8,
//                   right: 8,
//                 ),
//                 child: Stack(children: [
//                   // StreamBuilder<List<Chatmodel>>(
//                   //   stream: chatcontroller.getMessages(groupModel!.id!),
//                   //   builder: (context, snapshot) {
//                   //     if (snapshot.connectionState == ConnectionState.waiting) {
//                   //       return const Center(child: CircularProgressIndicator());
//                   //     }
//                   //     if (snapshot.hasError) {
//                   //       return Center(child: Text("Error: ${snapshot.error}"));
//                   //     }
//                   //     if (snapshot.hasData && snapshot.data!.isNotEmpty) {
//                   //       return ListView.builder(
//                   //         reverse: true, // Keep latest messages at the bottom
//                   //         physics: const BouncingScrollPhysics(),
//                   //         itemCount: snapshot.data!.length,
//                   //         itemBuilder: (context, index) {
//                   //           var data = snapshot.data![index];

//                   //           // Convert timestamp to readable format
//                   //           String formattedTime = "";
//                   //           if (data.timestamp != null) {
//                   //             DateTime dateTime = DateTime.parse(
//                   //                 data.timestamp!); // Parse String to DateTime
//                   //             formattedTime = DateFormat('hh:mm a')
//                   //                 .format(dateTime); // Format as "10:30 PM"
//                   //           }

//                   //           return ChatBubble(
//                   //             message: data.message.toString(),
//                   //             imageUrl: data.imageUrl,
//                   //             isComming: data.receiverId ==
//                   //                     profileController.currentUser.value.id
//                   //                 ? true
//                   //                 : false,
//                   //             time: formattedTime,
//                   //             status: "read", // Pass formatted time
//                   //           );
//                   //         },
//                   //       );
//                   //     }
//                   //     return const Center(child: Text("No messages yet"));
//                   //   },
//                   // ),
//                   Obx(
//                     () => chatcontroller.selectedImagePath.value
//                             .trim()
//                             .isNotEmpty
//                         ? Positioned(
//                             bottom: 5,
//                             left: 0,
//                             right: 0,
//                             child: Stack(
//                               children: [
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(20),
//                                   child: Image.file(
//                                     File(
//                                         chatcontroller.selectedImagePath.value),
//                                     fit: BoxFit.contain,
//                                     width: double.infinity,
//                                     height: Get.height * 0.7,
//                                   ),
//                                 ),
//                                 Positioned(
//                                   right: 5,
//                                   child: Column(
//                                     children: [
//                                       GestureDetector(
//                                         onTap: () {
//                                           chatcontroller
//                                               .selectedImagePath.value = '';
//                                         },
//                                         child: Icon(
//                                           Icons.close_rounded,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                       GestureDetector(
//                                         onTap: () async {},
//                                         child: Icon(
//                                           Icons.download,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )
//                         : SizedBox.shrink(),
//                   )
//                 ]),
//               ),
//             ),
//             Padding(
//                 padding: const EdgeInsets.only(bottom: 2, left: 3, right: 3),
//                 child: GroupTypeMessage(
//                     messageController: messageController,
//                     focusNode: focusNode,
//                     isTyping: isTyping,
//                     chatcontroller: chatcontroller,
//                     imagepickercontroller: imagePickerController,
//                     groupModel: groupModel)
//                 // typingbutton(
//                 //   messageController: messageController,
//                 //   focusNode: focusNode,
//                 //   isTyping: isTyping,
//                 //   chatcontroller: chatcontroller,
//                 //   userModel: userModel,
//                 //   imagepickercontroller: imagePickerController,
//                 // ),
//                 ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/View/group/groupInfo/groupInfo.dart';
import 'package:chatapp/View/groupChate/group_type_message.dart';
import 'package:chatapp/controller/chatController.dart';
import 'package:chatapp/controller/DetailsController.dart';
import 'package:chatapp/controller/groupController.dart';
import 'package:chatapp/model/groupModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import '../../controller/imagePickerController.dart';
import '../../controller/profileController.dart';
import '../../model/chatmodel.dart';
import '../chat/widgets/chatBubble.dart';

class GroupChatPage extends StatelessWidget {
  final GroupModel? groupModel;
  GroupChatPage({required this.groupModel, super.key});

  final ProfileController profileController = Get.put(ProfileController());
  final Detailscontroller detailscontroller = Get.find<Detailscontroller>();
  final Chatcontroller chatcontroller = Get.put(Chatcontroller());
  final TextEditingController messageController = TextEditingController();
  final ImagePickerController imagePickerController =
      Get.put(ImagePickerController());
  final Groupcontroller groupController = Get.put(Groupcontroller());
  final RxBool isTyping = false.obs;
  final RxBool showEmojiPicker = false.obs;
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          title: GestureDetector(
            onTap: () {
              Get.to(GroupInfo(
                groupModel: groupModel,
              ));
            },
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                GestureDetector(
                  onTap: () {
                    if (groupModel?.profileUrl?.isNotEmpty ?? false) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.height * 0.33,
                              child: PhotoView(
                                imageProvider: CachedNetworkImageProvider(
                                    groupModel!.profileUrl!),
                                minScale: PhotoViewComputedScale.contained,
                                maxScale: PhotoViewComputedScale.covered * 2,
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: (groupModel?.profileUrl?.isNotEmpty ??
                            false)
                        ? CachedNetworkImageProvider(groupModel!.profileUrl!)
                        : const NetworkImage('https://picsum.photos/200/300')
                            as ImageProvider,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      groupModel?.name ?? "User",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "online",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
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
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Stack(
                  children: [
                    // Uncomment this StreamBuilder when chatcontroller.getMessages() is properly implemented

                    StreamBuilder<List<Chatmodel>>(
                      stream: groupController.getGroupMessage(groupModel!.id!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(
                              child: Text("Error: ${snapshot.error}"));
                        }
                        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                          return ListView.builder(
                            reverse: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              var data = snapshot.data![index];
                              String formattedTime = "";
                              if (data.timestamp != null) {
                                DateTime dateTime =
                                    DateTime.parse(data.timestamp!);
                                formattedTime =
                                    DateFormat('hh:mm a').format(dateTime);
                              }
                              return ChatBubble(
                                message: data.message.toString(),
                                imageUrl: data.imageUrl,
                                isComming: data.senderId ==
                                        profileController.currentUser.value.id
                                    ? false
                                    : true,
                                time: formattedTime,
                                status: "read",
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
                                      File(chatcontroller
                                          .selectedImagePath.value),
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
                                          child: const Icon(
                                            Icons.close_rounded,
                                            color: Colors.white,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () async {},
                                          child: const Icon(
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
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 2, left: 3, right: 3),
              child: GroupTypeMessage(
                messageController: messageController,
                focusNode: focusNode,
                isTyping: isTyping,
                chatcontroller: chatcontroller,
                imagepickercontroller: imagePickerController,
                groupModel: groupModel,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
