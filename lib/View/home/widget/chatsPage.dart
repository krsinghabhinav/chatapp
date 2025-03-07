import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/config/images.dart';
import 'package:chatapp/controller/DetailsController.dart';
import 'package:chatapp/controller/chatController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart'; // Import the photo_view package

import '../../../model/chatRoomModel.dart';
import '../../chat/ChatpageDetails.dart';

class Chatspage extends StatelessWidget {
  Chatspage({super.key});

  final Detailscontroller detailscontroller = Get.put(Detailscontroller());
  final Chatcontroller chatcontroller = Get.put(Chatcontroller());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ChatRoomModel>>(
      stream:
          chatcontroller.getChatRoomList(), // Listening to real-time updates
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No chats available"));
        }

        var chatRooms = snapshot.data!; // Get chat room data
        String currentUserId = chatcontroller.auth.currentUser!.uid;

        return ListView.builder(
          padding: const EdgeInsets.all(0),
          itemCount: chatRooms.length,
          itemBuilder: (context, index) {
            var dataList = chatRooms[index];

            // Check who is the other user (opponent in chat)
            var opponent = dataList.sender!.id == currentUserId
                ? dataList.receiver // If sender is current user, show receiver
                : dataList.sender; // If receiver is current user, show sender
            print("===opponent!.profileImage==${opponent!.profileImage}");
            // Convert timestamp to readable format
            String formattedTime = "";
            if (dataList.lastMessageTimestamp != null) {
              DateTime dateTime =
                  DateTime.parse(dataList.lastMessageTimestamp!);
              formattedTime = DateFormat('hh:mm a').format(dateTime);
            }

            if (opponent == null) {
              return const SizedBox();
            }

            return GestureDetector(
              onTap: () {
                detailscontroller.setChatDetails(
                  newName: opponent.name ?? "Unknown",
                  newImage: opponent.profileImage ?? "",
                  newMessage: dataList.lastMessage ?? "No messages yet",
                );
                Get.to(ChatpageDetails(userModel: opponent));
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

                              // Show the zoomable image in a dialog
                              if (opponent.profileImage != null &&
                                  opponent.profileImage!.isNotEmpty) {
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
                                          imageProvider:
                                              CachedNetworkImageProvider(
                                            opponent.profileImage!,
                                          ),
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
                              }
                            },
                            child: CircleAvatar(
                              radius: 28,
                              backgroundColor: const Color.fromARGB(
                                  255, 49, 49, 49), // Fallback color
                              backgroundImage: (opponent.profileImage != null &&
                                      opponent.profileImage!.isNotEmpty)
                                  ? CachedNetworkImageProvider(
                                      opponent.profileImage!)
                                  : const NetworkImage(
                                      'https://picsum.photos/200/300'),
                              child: (opponent.profileImage == null ||
                                      opponent.profileImage!.isEmpty)
                                  ? const Icon(Icons.person,
                                      size: 28, color: Colors.grey)
                                  : null, // Show an icon if image is null
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                          width: 10), // Add spacing between avatar and text
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // Center text vertically
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween, // Name on left, time on right
                                children: [
                                  Expanded(
                                    child: Text(
                                      opponent.name ?? "Unknown",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                      overflow: TextOverflow
                                          .ellipsis, // Prevent text overflow
                                    ),
                                  ),
                                  Text(
                                    formattedTime,
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 12, right: 0),
                              child: Text(
                                dataList.lastMessage ?? "No messages yet",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
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
        );
      },
    );
  }
}













// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:chatapp/config/images.dart';
// import 'package:chatapp/controller/DetailsController.dart';
// import 'package:chatapp/controller/chatController.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// import '../../../model/chatRoomModel.dart';
// import '../../chat/ChatpageDetails.dart';

// class Chatspage extends StatelessWidget {
//   Chatspage({super.key});

//   final Detailscontroller detailscontroller = Get.put(Detailscontroller());
//   final Chatcontroller chatcontroller = Get.put(Chatcontroller());

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<List<ChatRoomModel>>(
//       stream:
//           chatcontroller.getChatRoomList(), // Listening to real-time updates
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return const Center(child: Text("No chats available"));
//         }

//         var chatRooms = snapshot.data!; // Get chat room data
//         String currentUserId = chatcontroller.auth.currentUser!.uid;

//         return ListView.builder(
//           padding: const EdgeInsets.all(0),
//           itemCount: chatRooms.length,
//           itemBuilder: (context, index) {
//             var dataList = chatRooms[index];

//             // Check who is the other user (opponent in chat)
//             var opponent = dataList.sender!.id == currentUserId
//                 ? dataList.receiver // If sender is current user, show receiver
//                 : dataList.sender; // If receiver is current user, show sender

//             // Convert timestamp to readable format
//             String formattedTime = "";
//             if (dataList.lastMessageTimestamp != null) {
//               DateTime dateTime =
//                   DateTime.parse(dataList.lastMessageTimestamp!);
//               formattedTime = DateFormat('hh:mm a').format(dateTime);
//             }

//             if (opponent == null) {
//               return const SizedBox();
//             }

//             return GestureDetector(
//               onTap: () {
//                 detailscontroller.setChatDetails(
//                   newName: opponent.name ?? "Unknown",
//                   newImage: opponent.profileImage ?? "",
//                   newMessage: dataList.lastMessage ?? "No messages yet",
//                 );
//                 Get.to(ChatpageDetails(userModel: opponent));
//               },
//               child: Card(
//                 color: const Color.fromARGB(0, 255, 255, 255),
//                 elevation: 0,
//                 child: SizedBox(
//                   height: 68,
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 0),
//                         child: Center(
//                           child: CircleAvatar(
//                             radius: 28,
//                             backgroundImage: opponent.profileImage != null &&
//                                     opponent.profileImage!.isNotEmpty
//                                     ? CachedNetworkImageProvider(opponent.profileImage!)
//                                 // ? NetworkImage(opponent.profileImage!)
//                                 : const NetworkImage(
//                                     'https://picsum.photos/200/300'),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                           width: 10), // Add spacing between avatar and text
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment
//                               .spaceBetween, // Center text vertically
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(top: 6),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment
//                                     .spaceBetween, // Name on left, time on right
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       opponent.name ?? "Unknown",
//                                       style: const TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.w400),
//                                       overflow: TextOverflow
//                                           .ellipsis, // Prevent text overflow
//                                     ),
//                                   ),
//                                   Text(
//                                     formattedTime,
//                                     style: const TextStyle(
//                                         fontSize: 14, color: Colors.grey),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.only(bottom: 12, right: 0),
//                               child: Text(
//                                 dataList.lastMessage ?? "No messages yet",
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 //  ListTile(
//                 //   leading: CircleAvatar(
//                 //     radius: 32,
//                 //     backgroundImage: opponent.profileImage != null &&
//                 //             opponent.profileImage!.isNotEmpty
//                 //         ? NetworkImage(opponent.profileImage!)
//                 //         : const NetworkImage('https://picsum.photos/200/300'),
//                 //   ),
//                 //   title: Text(opponent.name ?? "Unknown"),
//                 //   subtitle: Text(
//                 //     dataList.lastMessage ?? "No messages yet",
//                 //     maxLines: 1,
//                 //   ),
//                 //   trailing: Text(formattedTime),
//                 // ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }



//     // return ListView.builder(
//     //   padding: const EdgeInsets.all(2.0),
//     //   itemCount: chatcontroller.ourchatRoomList.length,
//     //   itemBuilder: (context, index) {
//     //     var dataList = chatcontroller.ourchatRoomList[index];
//     //     return GestureDetector(
//     //       onTap: () {
//     //         detailscontroller.setChatDetails(
//     //           newName: dataList.receiver!.name.toString(),
//     //           // newImage: chatList[index]["image"]!,
//     //           newImage: dataList.receiver!.profileImage,
//     //           // newMessage: chatList[index]["message"]!,
//     //           newMessage: dataList.lastMessage,
//     //         );

//     //         Get.toNamed("/chatPageDetails");
//     //       },
//     //       child: Obx(() => Card(
//     //             color: Theme.of(context).colorScheme.primaryContainer,
//     //             child: ListTile(
//     //               leading: CircleAvatar(
//     //                 radius: 32,
//     //                 backgroundImage: dataList.receiver!.profileImage != null
//     //                     ? NetworkImage(dataList.receiver!.profileImage!)
//     //                     : NetworkImage('https://picsum.photos/200/300'),
//     //               ),
//     //               title: Text(dataList.receiver!.name.toString()),
//     //               subtitle: Text(dataList.lastMessage.toString()),
//     //               // trailing: Text(chatList[index]["time"]!),
//     //               // trailing: Text(chatList[index]["time"]!),
//     //             ),
//     //           )),
//     //     );

//     //     // return Card(
//     //     //   color: Theme.of(context).colorScheme.primaryContainer,
//     //     //   margin: const EdgeInsets.symmetric(vertical: 5),
//     //     //   // child: Padding(
//     //     //   //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
//     //     //   //   child: Row(
//     //     //   //     children: [
//     //     //   //       CircleAvatar(
//     //     //   //         radius: 32,
//     //     //   //         backgroundImage: AssetImage(chatList[index]["image"]!),
//     //     //   //       ),
//     //     //   //       const SizedBox(width: 10),
//     //     //   //       Text(
//     //     //   //         chatList[index]["name"]!,
//     //     //   //         style: const TextStyle(
//     //     //   //             fontSize: 18, fontWeight: FontWeight.bold),
//     //     //   //       ),
//     //     //   //     ],
//     //     //   //   ),
//     //     //   // ),
//     //     // );
//     //   },
//     // );
// //   }
// // }



// // import 'package:chatapp/config/images.dart';
// // import 'package:chatapp/controller/DetailsController.dart';
// // import 'package:chatapp/controller/chatController.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:intl/intl.dart';

// // import '../../../model/chatRoomModel.dart';
// // import '../../chat/ChatpageDetails.dart';

// // class Chatspage extends StatelessWidget {
// //   Chatspage({super.key});
  
// //   final Detailscontroller detailscontroller = Get.put(Detailscontroller());
// //   final Chatcontroller chatcontroller = Get.put(Chatcontroller());

// //   @override
// //   Widget build(BuildContext context) {
// //     return StreamBuilder<List<ChatRoomModel>>(
// //       stream: chatcontroller.getChatRoomList(), // Listening to real-time updates
// //       builder: (context, snapshot) {
// //         if (snapshot.connectionState == ConnectionState.waiting) {
// //           return const Center(child: CircularProgressIndicator());
// //         }
        
// //         if (!snapshot.hasData || snapshot.data!.isEmpty) {
// //           return const Center(child: Text("No chats available"));
// //         }

// //         var chatRooms = snapshot.data!; // Get chat room data
        
// //         return ListView.builder(
// //           padding: const EdgeInsets.all(2.0),
// //           itemCount: chatRooms.length,
// //           itemBuilder: (context, index) {
// //             var dataList = chatRooms[index];
// //             var receiver = dataList.receiver;

// //             // Convert timestamp to readable format
// //             String formattedTime = "";
// //             if (dataList.lastMessageTimestamp != null) {
// //               DateTime dateTime = DateTime.parse(dataList.lastMessageTimestamp!);
// //               formattedTime = DateFormat('hh:mm a').format(dateTime);
// //             }

// //             if (receiver == null) {
// //               return const SizedBox();
// //             }

// //             return GestureDetector(
// //               onTap: () {
// //                 detailscontroller.setChatDetails(
// //                   newName: receiver.name ?? "Unknown",
// //                   newImage: receiver.profileImage ?? "",
// //                   newMessage: dataList.lastMessage ?? "No messages yet",
// //                 );
// //                 Get.to(ChatpageDetails(userModel: receiver));
// //               },
// //               child: Card(
// //                 color: Theme.of(context).colorScheme.primaryContainer,
// //                 child: ListTile(
// //                   leading: CircleAvatar(
// //                     radius: 32,
// //                     backgroundImage: receiver.profileImage != null &&
// //                             receiver.profileImage!.isNotEmpty
// //                         ? NetworkImage(receiver.profileImage!)
// //                         : const NetworkImage('https://picsum.photos/200/300'),
// //                   ),
// //                   title: Text(receiver.name ?? "Unknown"),
// //                   subtitle: Text(dataList.lastMessage ?? "No messages yet"),
// //                   trailing: Text(formattedTime),
// //                 ),
// //               ),
// //             );
// //           },
// //         );
// //       },
// //     );
// //   }
// // }


