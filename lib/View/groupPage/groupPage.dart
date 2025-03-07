import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/View/groupChate/groupChatePage.dart';
import 'package:chatapp/controller/groupController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Grouppage extends StatefulWidget {
  const Grouppage({super.key});

  @override
  State<Grouppage> createState() => _GrouppageState();
}

class _GrouppageState extends State<Grouppage> {
  final Groupcontroller groupcontroller = Get.put(Groupcontroller());

  @override
  void initState() {
    super.initState();
    print("Group Page initState");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return ListView(
          children: groupcontroller.groupList.map((group) {
            String formattedTime = "";
            if (group.timeStamp != null) {
              DateTime dateTime = DateTime.parse(group.timeStamp!);
              formattedTime = DateFormat('hh:mm a').format(dateTime);
            }

            return GestureDetector(
              onTap: () {
                Get.to(GroupChatPage(groupModel: group));
              },
              child: Card(
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
                            backgroundImage: (group.profileUrl != null &&
                                    group.profileUrl!.isNotEmpty)
                                ? CachedNetworkImageProvider(group.profileUrl!)
                                : null,
                            child: (group.profileUrl == null ||
                                    group.profileUrl!.isEmpty)
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    group.name ?? "Unknown",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  formattedTime ?? " no time",
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(
                              group.id ?? "No messages yet",
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
              ),
            );
          }).toList(),
        );
      }),
    );
  }
}
