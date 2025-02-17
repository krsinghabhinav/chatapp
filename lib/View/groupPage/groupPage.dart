import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/View/home/widget/chatsPage.dart';
import 'package:flutter/material.dart';

class Grouppage extends StatefulWidget {
  const Grouppage({super.key});

  @override
  State<Grouppage> createState() => _GrouppageState();
}

class _GrouppageState extends State<Grouppage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (BuildContext context, int index) {
        return Card(
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
                        // showDialog(
                        //   context: context,
                        //   builder: (context) {
                        //     return Dialog(
                        //       child: Container(
                        //         width: MediaQuery.of(context).size.width *
                        //             0.9,
                        //         height:
                        //             MediaQuery.of(context).size.height *
                        //                 0.33,
                        //         child: PhotoView(
                        //           imageProvider: opponent.profileImage !=
                        //                       null &&
                        //                   opponent
                        //                       .profileImage!.isNotEmpty
                        //               ? CachedNetworkImageProvider(
                        //                   opponent.profileImage!)
                        //               : NetworkImage(
                        //                   'https://picsum.photos/200/300'),
                        //           minScale:
                        //               PhotoViewComputedScale.contained,
                        //           maxScale:
                        //               PhotoViewComputedScale.covered * 2,
                        //         ),
                        //       ),
                        //     );
                        //   },
                        // );
                      },
                      child: CircleAvatar(
                          radius: 28,
                          backgroundColor: const Color.fromARGB(
                              255, 49, 49, 49), // Placeholder background color
                          backgroundImage:
                              NetworkImage('https://picsum.photos/200/300'),
                          child:
                              Icon(Icons.person, size: 28, color: Colors.grey)
                          // Show an icon if image is null
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
                                "abhinav" ?? "Unknown",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                                overflow: TextOverflow
                                    .ellipsis, // Prevent text overflow
                              ),
                            ),
                            Text(
                              "9 pm",
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12, right: 0),
                        child: Text(
                          "No messages yet",
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
        );
      },
    );
  }
}
