import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/View/UserProfile/userprofile_screen.dart';
import 'package:chatapp/View/callpage/AudioCallPage.dart';
import 'package:chatapp/View/callpage/videocallPage.dart';
import 'package:chatapp/controller/chatController.dart';
import 'package:chatapp/controller/DetailsController.dart';
import 'package:chatapp/model/chatmodel.dart';
import 'package:chatapp/model/userModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';

import '../../controller/callCntroller.dart';
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
  CallController callcntroller = Get.put(CallController());
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
                    if (detailscontroller.image.value.isNotEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.height * 0.33,
                              child: PhotoView(
                                imageProvider: CachedNetworkImageProvider(
                                  detailscontroller.image.value,
                                ),
                                minScale: PhotoViewComputedScale.contained,
                                maxScale: PhotoViewComputedScale.covered * 2,
                              ),
                            ),
                          );
                        },
                      );
                    }
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
                  if (userModel != null) {
                    Get.to(UserprofileScreen(userModel: userModel));
                  }
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
                        const SizedBox(height: 3),

                        // StreamBuilder for status
                        StreamBuilder<UserModel>(
                          stream:
                              chatcontroller.getStatus(userModel?.id ?? "noid"),
                          builder:
                              (context, AsyncSnapshot<UserModel> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text("Loading...");
                            }
                            if (snapshot.hasError) {
                              return const Text("Error fetching status");
                            }

                            // Get the status safely
                            String status = snapshot.data?.status ?? "Offline";

                            return Text(
                              status,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: status == "Online"
                                    ? Colors.green
                                    : const Color.fromARGB(255, 255, 0, 0),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(
                  Audiocallpage(target: userModel!),
                );
                callcntroller.callAction(
                    userModel!, profileController.currentUser.value, "audio");
              },
              icon: const Icon(Icons.phone),
            ),
            const SizedBox(width: 15),
            GestureDetector(
                onTap: () {
                Get.to(
                  Videocallpage(target: userModel!),
                );
                  callcntroller.callAction(
                      userModel!, profileController.currentUser.value, "video");
                },
                child: const Icon(Icons.video_call)),
            const SizedBox(width: 15),
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
