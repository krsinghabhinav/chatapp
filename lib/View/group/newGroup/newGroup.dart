import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/View/group/newGroup/grouptitle.dart';
import 'package:chatapp/controller/contactController.dart';
import 'package:chatapp/controller/groupController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'selectedMemberList.dart';

class NewgroupPage extends StatefulWidget {
  const NewgroupPage({super.key});

  @override
  State<NewgroupPage> createState() => _NewgroupPageState();
}

class _NewgroupPageState extends State<NewgroupPage> {
  Contactcontroller contactController = Get.put(Contactcontroller());
  Groupcontroller groupController = Get.put(Groupcontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text('New Group'),
      ),
      floatingActionButton: Obx(() => FloatingActionButton(
            backgroundColor: groupController.groupMembers.isEmpty
                ? Colors.grey
                : Colors.blue,
            onPressed: () {
              if (groupController.groupMembers.isEmpty) {
                Get.snackbar('Empty', "Please Selecte alteast one memeber");
              } else {
                Get.to(Grouptitle());
              }
            },
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectedMemberList(),
            Text(
              "Contacts on sampark",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              overflow: TextOverflow.ellipsis,
            ),
            StreamBuilder(
              stream: contactController.getContacts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No contacts available"));
                }

                var contacts =
                    snapshot.data!; // Assuming this is a List of contacts

                return Expanded(
                  child: ListView.builder(
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      var contact = contacts[index];
                      return GestureDetector(
                        onTap: () {
                          groupController.selectMember(snapshot.data![index]);
                          print("tapped");
                        },
                        child: Card(
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
                                            image: contact
                                                    .profileImage!.isNotEmpty
                                                ? CachedNetworkImageProvider(
                                                    contact.profileImage!)
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
                                        padding: const EdgeInsets.only(top: 6),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                contact.name ?? "Unknown",
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w400),
                                                overflow: TextOverflow.ellipsis,
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
                                              contact.email ??
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
                        ),
                      );
                    },
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
