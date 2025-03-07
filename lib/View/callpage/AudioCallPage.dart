import 'package:chatapp/controller/chatController.dart';
import 'package:chatapp/controller/profileController.dart';
import 'package:chatapp/model/userModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../config/AppString.dart';

class Audiocallpage extends StatelessWidget {
  final UserModel target;
  Audiocallpage({super.key, required this.target});

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.put(ProfileController());
    Chatcontroller chatController = Get.put(Chatcontroller());
    var callId = chatController.getCreateRoomId(target.id!);
    return ZegoUIKitPrebuiltCall(
      appID: ZegoCloudConfig.appId, // your AppID,
      appSign: ZegoCloudConfig.appSign,
      userID: profileController.currentUser.value.id ?? "root",
      userName: profileController.currentUser.value.name ?? "root",
      callID: callId,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
    );
    ;
  }
}
