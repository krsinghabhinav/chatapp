import 'package:chatapp/controller/chatController.dart';
import 'package:chatapp/controller/profileController.dart';
import 'package:chatapp/model/userModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../config/AppString.dart';

class Videocallpage extends StatelessWidget {
  final UserModel target;
  Videocallpage({super.key, required this.target});

  @override
  Widget build(BuildContext context) {
    // Use Get.find to retrieve existing instances instead of creating new ones
    ProfileController profileController = Get.find<ProfileController>();
    Chatcontroller chatController = Get.find<Chatcontroller>();

    var callId = chatController.getCreateRoomId(target.id!);

    return ZegoUIKitPrebuiltCall(
      appID: ZegoCloudConfig.appId, // your AppID
      appSign: ZegoCloudConfig.appSign,
      userID: profileController.currentUser.value.id ?? "root",
      userName: profileController.currentUser.value.name ?? "root",
      callID: callId,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}
