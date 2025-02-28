import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/View/chat/ChatpageDetails.dart';
import 'package:chatapp/View/group/newGroup/newGroup.dart';
import 'package:chatapp/controller/profileController.dart';
import 'package:chatapp/model/userModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import '../../config/images.dart';
import '../../controller/DetailsController.dart';
import '../../controller/chatController.dart';
import '../../controller/contactController.dart';
import 'widget/NewContactGroup .dart';

class ContactScreen extends StatelessWidget {
  ContactScreen({super.key});

  final Detailscontroller detailscontroller = Get.put(Detailscontroller());
  final Contactcontroller contactcontroller = Get.put(Contactcontroller());
  final ProfileController profileController = Get.put(ProfileController());

  final RxBool isSearchVisible = false.obs; // Controls search visibility
  UserModel? userModel;
  Chatcontroller chatcontroller = Get.put(Chatcontroller()); // Add this line
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss keyboard when tapping outside
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Select Contact', style: TextStyle(fontSize: 19)),
              Text(
                'Select Contact',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          actions: [
            Obx(() => IconButton(
                  onPressed: () {
                    isSearchVisible.value = !isSearchVisible.value;
                  },
                  icon: isSearchVisible.value
                      ? const Icon(Icons.cancel)
                      : const Icon(Icons.search),
                )),
            const SizedBox(width: 5),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Bar
                Obx(() {
                  return isSearchVisible.value
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: SizedBox(
                            height: 50,
                            child: TextField(
                              textInputAction: TextInputAction.search,
                              controller: contactcontroller.searchController,
                              decoration: InputDecoration(
                                hintText: "Search Contacts",
                                hintStyle: const TextStyle(
                                    color: Color.fromARGB(255, 141, 141, 141)),
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onChanged: (value) {
                                contactcontroller
                                    .searchChanged(); // Trigger filtering when text changes
                              },
                            ),
                          ),
                        )
                      : const SizedBox.shrink();
                }),

                const SizedBox(height: 10),

                // New Contact & Group Buttons
                NewContactGroup(
                  icon: Icons.person_add,
                  title: "New Contact",
                  onTab: () {
                    print("New Contact Clicked");
                  },
                ),
                const SizedBox(height: 10),
                NewContactGroup(
                  icon: Icons.group_add,
                  title: "New Group",
                  onTab: () {
                    print("New Group Clicked");
                    Get.to(NewgroupPage());
                  },
                ),

                const SizedBox(height: 10),

                // Section Title
                const Text(
                  "Contacts and Sampark",
                  style: TextStyle(
                    fontSize: 15,
                    color: Color.fromARGB(255, 153, 151, 151),
                  ),
                ),

                const SizedBox(height: 5),

                // User List
                Obx(() {
                  if (contactcontroller.isLoading.value) {
                    return const Center(
                        child:
                            CircularProgressIndicator()); // Show loader while fetching data
                  }

                  if (contactcontroller.filterList.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Center(child: Text("No contacts found.")),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(2.0),
                    shrinkWrap:
                        true, // Ensures ListView takes only necessary space
                    physics:
                        const NeverScrollableScrollPhysics(), // Disables inner scrolling
                    itemCount: contactcontroller.filterList.length,
                    itemBuilder: (context, index) {
                      var data = contactcontroller.filterList[index];

                      return GestureDetector(
                        onTap: () {
                          detailscontroller.setChatDetails(
                            newName: data.name ?? "Unknown",
                            newImage: data.profileImage ??
                                "https://picsum.photos/200/300",
                            newMessage: data.phoneNumber ?? "No Phone Number",
                          );
                          chatcontroller.getCreateRoomId(data.id.toString());
                          print("data id ==== ${data.id}");
                          // Get.toNamed("/chatPageDetails");
                          Get.to(
                            () => ChatpageDetails(
                              userModel: data,
                            ),
                          );
                        },
                        child: Card(
                          color: Colors.transparent,
                          elevation: 0,
                          child: ListTile(
                            leading: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.33,
                                        child: PhotoView(
                                          imageProvider: data.profileImage !=
                                                      null &&
                                                  data.profileImage!.isNotEmpty
                                              ? CachedNetworkImageProvider(
                                                  data.profileImage!)
                                              : const NetworkImage(
                                                  'https://picsum.photos/200/300'),
                                          minScale:
                                              PhotoViewComputedScale.contained,
                                          maxScale:
                                              PhotoViewComputedScale.covered *
                                                  2,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },

                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color.fromARGB(255, 71, 71, 71),
                                  image: DecorationImage(
                                    image: data.profileImage!.isNotEmpty
                                        ? CachedNetworkImageProvider(
                                            data.profileImage!)
                                        : const NetworkImage(
                                            'https://picsum.photos/200/300'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              // child: Container(
                              //   width: 64, // Diameter (2 * radius)
                              //   height: 64, // Diameter (2 * radius)
                              //   decoration: BoxDecoration(
                              //     shape: BoxShape.circle,
                              //     image: DecorationImage(
                              //       image: data.profileImage != null &&
                              //               data.profileImage!.isNotEmpty
                              //           ? NetworkImage(data.profileImage!)
                              //           : const NetworkImage(
                              //               'https://picsum.photos/200/300'),
                              //       fit: BoxFit
                              //           .fill, // Ensures full image fits in the circle
                              //     ),
                              //   ),
                              // ),
                            ),
                            title: Text(data.name ?? "Unknown"),
                            subtitle:
                                Text(data.phoneNumber ?? "No Phone Number"),
                            trailing: Text(data.email ==
                                    profileController.currentUser.value.email
                                ? "You"
                                : ""),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
