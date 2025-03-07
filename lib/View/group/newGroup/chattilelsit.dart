// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';

// import '../../../model/userModel.dart';

// class ChattileList extends StatelessWidget {
//   const ChattileList({
//     super.key,
//     required this.contact,
//   });

//   final UserModel contact;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.transparent,
//       elevation: 0,
//       child: SizedBox(
//         height: 68,
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 0),
//               child: Center(
//                 child: GestureDetector(
//                   onTap: () {
//                     print("Tapped on Profile Image");
//                   },
//                   child: Container(
//                     width: 60,
//                     height: 60,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: const Color.fromARGB(
//                           255, 71, 71, 71),
//                       image: DecorationImage(
//                         image: contact
//                                 .profileImage!.isNotEmpty
//                             ? CachedNetworkImageProvider(
//                                 contact.profileImage!)
//                             : const NetworkImage(
//                                 'https://picsum.photos/200/300'),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   // child: CircleAvatar(
//                   //   radius: 28,
//                   //   backgroundColor: const Color.fromARGB(
//                   //       255, 49, 49, 49),
//                   //   backgroundImage: NetworkImage(contact
//                   //           .profileImage ??
//                   //       'https://picsum.photos/200/300'),
//                   //   child: contact.profileImage == null
//                   //       ? const Icon(Icons.person,
//                   //           size: 28, color: Colors.grey)
//                   //       : null,
//                   // ),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 10),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment:
//                     CrossAxisAlignment.start,
//                 mainAxisAlignment:
//                     MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(top: 6),
//                     child: Row(
//                       mainAxisAlignment:
//                           MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           child: Text(
//                             contact.name ?? "Unknown",
//                             style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight:
//                                     FontWeight.w400),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                         // Text(
//                         //   contact. ?? "N/A",
//                         //   style: const TextStyle(fontSize: 14, color: Colors.grey),
//                         // ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(
//                         bottom: 12, right: 0),
//                     child: Row(
//                       children: [
//                         Text(
//                           contact.email ??
//                               "No status available",
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
