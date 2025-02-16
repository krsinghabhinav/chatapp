// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ChatBubble extends StatelessWidget {
//   final String message;
//   final bool? isComming;
//   final String? time;
//   final String? status;
//   final String? imageUrl;

//   ChatBubble({
//     super.key,
//     required this.message,
//     this.isComming,
//     this.time,
//     this.status,
//     this.imageUrl,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment:
//           isComming == true ? Alignment.centerLeft : Alignment.centerRight,
//       child: Column(
//         crossAxisAlignment: isComming == true
//             ? CrossAxisAlignment.start
//             : CrossAxisAlignment.end,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(bottom: 15),
//             child: Container(
//               constraints: BoxConstraints(maxWidth: Get.width * 0.55),
//               decoration: BoxDecoration(
//                 color: isComming == true
//                     ? Theme.of(context).colorScheme.primaryContainer
//                     : Theme.of(context).colorScheme.primaryContainer,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(12),
//                   topRight: Radius.circular(12),
//                   bottomLeft: isComming == true
//                       ? Radius.circular(0)
//                       : Radius.circular(12),
//                   bottomRight: isComming == true
//                       ? Radius.circular(12)
//                       : Radius.circular(0),
//                 ),
//               ),
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: isComming == true
//                     ? CrossAxisAlignment.start
//                     : CrossAxisAlignment.end,
//                 children: [
//                   if (imageUrl != null && imageUrl!.isNotEmpty)
//                     Column(
//                       children: [
//                         // CachedNetworkImage(
//                         //   imageUrl: imageUrl!,
//                         //   width: double.infinity,
//                         //   height: 130,
//                         //   fit: BoxFit.fill,
//                         // ),
//                         Image.network(
//                           imageUrl!,
//                           width: double.infinity,
//                           height: 130,
//                           fit: BoxFit.cover,
//                         ),
//                         if (message.isNotEmpty) SizedBox(height: 8),
//                       ],
//                     ),
//                   if (message.isNotEmpty)
//                     Text(
//                       message,
//                       style: TextStyle(
//                         fontSize: 14,
//                       ),
//                     ),
//                   if (time != null)
//                     Padding(
//                       padding: const EdgeInsets.only(top: 4),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Text(
//                             time!,
//                             style: TextStyle(
//                               fontSize: 10,
//                               color: Colors.grey,
//                             ),
//                           ),
//                           if (isComming == false && status != null)
//                             Row(
//                               children: [
//                                 SizedBox(width: 4),
//                                 if (status == "sent")
//                                   Icon(
//                                     Icons.done,
//                                     size: 12,
//                                     color: Colors.grey,
//                                   ),
//                                 if (status == "delivered")
//                                   Icon(
//                                     Icons.done_all,
//                                     size: 12,
//                                     color: Colors.grey,
//                                   ),
//                                 if (status == "read")
//                                   Icon(
//                                     Icons.done_all,
//                                     size: 12,
//                                     color: Colors.blue,
//                                   ),
//                               ],
//                             ),
//                         ],
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:photo_view/photo_view.dart';

// class ChatBubble extends StatelessWidget {
//   final String message;
//   final bool? isComming;
//   final String? time;
//   final String? status;
//   final String? imageUrl;

//   ChatBubble({
//     super.key,
//     required this.message,
//     this.isComming,
//     this.time,
//     this.status,
//     this.imageUrl,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment:
//           isComming == true ? Alignment.centerLeft : Alignment.centerRight,
//       child: Column(
//         crossAxisAlignment: isComming == true
//             ? CrossAxisAlignment.start
//             : CrossAxisAlignment.end,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(bottom: 15),
//             child: Container(
//               constraints: BoxConstraints(maxWidth: Get.width * 0.55),
//               decoration: BoxDecoration(
//                 color: Theme.of(context).colorScheme.primaryContainer,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(12),
//                   topRight: Radius.circular(12),
//                   bottomLeft: isComming == true
//                       ? Radius.circular(0)
//                       : Radius.circular(12),
//                   bottomRight: isComming == true
//                       ? Radius.circular(12)
//                       : Radius.circular(0),
//                 ),
//               ),
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: isComming == true
//                     ? CrossAxisAlignment.start
//                     : CrossAxisAlignment.end,
//                 children: [

//                   imageUrl==""? Text(
//                       message,
//                       style: TextStyle(fontSize: 14),
//                     ):
//                     Column(
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             showDialog(
//                               context: context,
//                               builder: (context) {
//                                 return Dialog(
//                                   child: Container(
//                                     width:
//                                         MediaQuery.of(context).size.width * 1,
//                                     height: MediaQuery.of(context).size.height *
//                                         0.33,
//                                     child: PhotoView(
//                                       imageProvider: imageUrl!.isNotEmpty
//                                           ? CachedNetworkImageProvider(
//                                               imageUrl!)
//                                           : const NetworkImage(
//                                               'https://picsum.photos/200/300'),
//                                       minScale:
//                                           PhotoViewComputedScale.contained,
//                                       maxScale:
//                                           PhotoViewComputedScale.contained * 2,
//                                     ),
//                                   ),
//                                 );
//                               },
//                             );
//                           },
//                           child: Container(
//                             width: double.infinity,
//                             height: Get.height * 0.3,
//                             decoration: BoxDecoration(
//                               // shape: BoxShape.circle,
//                               image: DecorationImage(
//                                 image: imageUrl!.isNotEmpty
//                                     ? CachedNetworkImageProvider(imageUrl!)
//                                     : const NetworkImage(
//                                         'https://picsum.photos/200/300'),
//                                 fit: BoxFit.fill,
//                               ),
//                             ),
//                           ),
//                         ),

//                         // CachedNetworkImage(
//                         //   imageUrl: imageUrl!,
//                         //   width: double.infinity,
//                         //   height: 130,
//                         //   fit: BoxFit.fill,
//                         //   placeholder: (context, url) => Center(
//                         //       child: CircularProgressIndicator(
//                         //     strokeWidth: 2,
//                         //   )),
//                         //   errorWidget: (context, url, error) =>
//                         //       Icon(Icons.error),
//                         // ),
//                         if (message.isNotEmpty) SizedBox(height: 8),
//                       ],
//                     ),

//                   if (time != null)
//                     Padding(
//                       padding: const EdgeInsets.only(top: 4),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Text(
//                             time!,
//                             style: TextStyle(fontSize: 10, color: Colors.grey),
//                           ),
//                           if (isComming == false && status != null)
//                             Row(
//                               children: [
//                                 SizedBox(width: 4),
//                                 if (status == "sent")
//                                   Icon(Icons.done,
//                                       size: 12, color: Colors.grey),
//                                 if (status == "delivered")
//                                   Icon(Icons.done_all,
//                                       size: 12, color: Colors.grey),
//                                 if (status == "read")
//                                   Icon(Icons.done_all,
//                                       size: 12, color: Colors.blue),
//                               ],
//                             ),
//                         ],
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:photo_view/photo_view.dart';

// class ChatBubble extends StatelessWidget {
//   final String message;
//   final bool? isComming;
//   final String? time;
//   final String? status;
//   final String? imageUrl;

//   ChatBubble({
//     super.key,
//     required this.message,
//     this.isComming,
//     this.time,
//     this.status,
//     this.imageUrl,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment:
//           isComming == true ? Alignment.centerLeft : Alignment.centerRight,
//       child: Column(
//         crossAxisAlignment: isComming == true
//             ? CrossAxisAlignment.start
//             : CrossAxisAlignment.end,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(bottom: 15),
//             child: Container(
//               constraints: BoxConstraints(maxWidth: Get.width * 0.55),
//               decoration: BoxDecoration(
//                 color: Theme.of(context).colorScheme.primaryContainer,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(12),
//                   topRight: Radius.circular(12),
//                   bottomLeft: isComming == true
//                       ? Radius.circular(0)
//                       : Radius.circular(12),
//                   bottomRight: isComming == true
//                       ? Radius.circular(12)
//                       : Radius.circular(0),
//                 ),
//               ),
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: isComming == true
//                     ? CrossAxisAlignment.start
//                     : CrossAxisAlignment.end,
//                 children: [
//                   if (imageUrl?.isNotEmpty == true)
//                     Column(
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             showDialog(
//                               context: context,
//                               builder: (context) {
//                                 return Dialog(
//                                   child: Container(
//                                     width:
//                                         MediaQuery.of(context).size.width * 1,
//                                     height: MediaQuery.of(context).size.height *
//                                         0.33,
//                                     child: PhotoView(
//                                       imageProvider:
//                                           CachedNetworkImageProvider(imageUrl!),
//                                       minScale:
//                                           PhotoViewComputedScale.contained,
//                                       maxScale:
//                                           PhotoViewComputedScale.contained * 2,
//                                     ),
//                                   ),
//                                 );
//                               },
//                             );
//                           },
//                           child: Container(
//                             width: double.infinity,
//                             height: Get.height * 0.3,
//                             decoration: BoxDecoration(
//                               image: DecorationImage(
//                                 image: CachedNetworkImageProvider(imageUrl!),
//                                 fit: BoxFit.fill,
//                               ),
//                             ),
//                           ),
//                         ),
//                         if (message.isNotEmpty) SizedBox(height: 8),
//                       ],
//                     )
//                   else
//                     Text(
//                       message,
//                       style: TextStyle(fontSize: 14),
//                     ),
//                   if (time != null)
//                     Padding(
//                       padding: const EdgeInsets.only(top: 4),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Text(
//                             time!,
//                             style: TextStyle(fontSize: 10, color: Colors.grey),
//                           ),
//                           if (isComming == false && status != null)
//                             Row(
//                               children: [
//                                 SizedBox(width: 4),
//                                 if (status == "sent")
//                                   Icon(Icons.done,
//                                       size: 12, color: Colors.grey),
//                                 if (status == "delivered")
//                                   Icon(Icons.done_all,
//                                       size: 12, color: Colors.grey),
//                                 if (status == "read")
//                                   Icon(Icons.done_all,
//                                       size: 12, color: Colors.blue),
//                               ],
//                             ),
//                         ],
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isComming;
  final String time;
  final String status;
  final String? imageUrl;

  ChatBubble({
    super.key,
    required this.message,
    required this.isComming,
    required this.time,
    required this.status,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isComming ? Alignment.centerLeft : Alignment.centerRight,
      child: Column(
        crossAxisAlignment:
            isComming ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Container(
              constraints: BoxConstraints(maxWidth: Get.width * 0.55),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft:
                      isComming ? Radius.circular(0) : Radius.circular(12),
                  bottomRight:
                      isComming ? Radius.circular(12) : Radius.circular(0),
                ),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: isComming
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.end,
                children: [
                  if (imageUrl != null && imageUrl!.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                child: PhotoView(
                                  imageProvider:
                                      CachedNetworkImageProvider(imageUrl!),
                                  minScale: PhotoViewComputedScale.contained,
                                  maxScale: PhotoViewComputedScale.covered * 2,
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: Get.height * 0.3,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(imageUrl!),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  if (message.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        message,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(time,
                            style: TextStyle(fontSize: 10, color: Colors.grey)),
                        if (!isComming && status.isNotEmpty) SizedBox(width: 4),
                        if (!isComming)
                          Icon(
                            status == "sent"
                                ? Icons.done
                                : status == "delivered"
                                    ? Icons.done_all
                                    : status == "read"
                                        ? Icons.done_all
                                        : Icons.access_time,
                            size: 12,
                            color: status == "read" ? Colors.blue : Colors.grey,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
