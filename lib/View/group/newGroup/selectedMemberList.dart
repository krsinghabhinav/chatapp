import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/groupController.dart';

class selectedMemberList extends StatelessWidget {
  selectedMemberList({
    super.key,
  });

  Groupcontroller groupController = Get.put(Groupcontroller());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
          children: groupController.groupMembers
              .map(
                (e) => Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.all(5),
                      height: 80,
                      width: 80,
                      // color: Colors.amber,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color.fromARGB(255, 71, 71, 71),
                          image: DecorationImage(
                            image: e.profileImage!.isNotEmpty
                                ? CachedNetworkImageProvider(e.profileImage!)
                                : const NetworkImage(
                                    'https://picsum.photos/200/300'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 8,
                      bottom: 8,
                      child: GestureDetector(
                          onTap: () {
                            groupController.groupMembers.remove(e);
                          },
                          child: Icon(Icons.close)),
                    )
                  ],
                ),
              )
              .toList(),
        ));
  }
}
