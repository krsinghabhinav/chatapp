import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/model/groupModel.dart';
import 'package:chatapp/model/userModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/profileController.dart';
import '../../UserProfile/widget/GroupMwmberaddUserinfo.dart';

class GroupInfo extends StatelessWidget {
  final GroupModel? groupModel;
  GroupInfo({super.key, this.groupModel});

  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(groupModel?.name ?? "Group Name"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserInfo(
              profileImage:
                  groupModel?.profileUrl ?? "https://picsum.photos/200/300",
              userName: groupModel?.name ?? "Unknown User",
              userEmail: groupModel!.description ?? "No description Available",
              groupId: groupModel?.id,
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Group Members",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              itemCount: groupModel?.members?.length ?? 0,
              shrinkWrap: true, // Makes the list take only needed space
              physics:
                  const NeverScrollableScrollPhysics(), // Disables independent scrolling
              itemBuilder: (context, index) {
                UserModel user = groupModel!.members![index];
// String formattedTime = "";
//             if (user. != null) {
//               DateTime dateTime = DateTime.parse(group.timeStamp!);
//               formattedTime = DateFormat('hh:mm a').format(dateTime);
//             }
                return Card(
                  color: Colors.transparent,
                  elevation: 0,
                  child: SizedBox(
                    height: 68,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: GestureDetector(
                            onTap: () {
                              print("Tapped on Profile Image");
                            },
                            child: CircleAvatar(
                              radius: 28,
                              backgroundColor:
                                  const Color.fromARGB(255, 49, 49, 49),
                              backgroundImage: (user.profileImage != null &&
                                      user.profileImage!.isNotEmpty)
                                  ? CachedNetworkImageProvider(
                                      user.profileImage!)
                                  : null,
                              child: (user.profileImage == null ||
                                      user.profileImage!.isEmpty)
                                  ? const Icon(Icons.person,
                                      size: 28, color: Colors.grey)
                                  : null,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      user.name ?? "Unknown",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    user.role == 'admin'
                                        ? "Admin"
                                        : "User" ?? " no time",
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text(
                                user.email ?? "No messages yet",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
