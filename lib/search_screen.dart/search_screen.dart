import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/View/home/HomePageScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

import '../View/chat/ChatpageDetails.dart';
import '../controller/DetailsController.dart';
import '../controller/chatController.dart';
import '../controller/contactController.dart';
import '../controller/profileController.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final Contactcontroller contactcontroller = Get.put(Contactcontroller());
  final ProfileController profileController = Get.put(ProfileController());
  final Detailscontroller detailscontroller = Get.put(Detailscontroller());
  Chatcontroller chatcontroller = Get.put(Chatcontroller()); // Add this line

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    contactcontroller.searchController.dispose();
    Get.to(HomePageScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            // title: Text('Search User List', style: ,),
            ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
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
            ),
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
                shrinkWrap: true, // Ensures ListView takes only necessary space
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
                                        MediaQuery.of(context).size.width * 0.9,
                                    height: MediaQuery.of(context).size.height *
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
                                          PhotoViewComputedScale.covered * 2,
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
                        subtitle: Text(data.phoneNumber ?? "No Phone Number"),
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
        ));
  }
}
