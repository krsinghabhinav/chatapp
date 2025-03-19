// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import '../models/ChatMessage.dart';

// class ChatScreen extends StatefulWidget {
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   List<ChatMessage> messages = [];
//   TextEditingController messageController = TextEditingController();
//   ChatMessage? replyingTo; // Stores the message being replied to

//   void sendMessage(String message) {
//     if (message.isNotEmpty) {
//       setState(() {
//         messages.add(ChatMessage(
//           message: message,
//           sender: "You",
//           replyTo: replyingTo?.message, // Attach reply message if any
//           timestamp: DateTime.now(),
//         ));
//         replyingTo = null; // Reset reply
//       });
//       messageController.clear();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Chat Reply with Swipe")),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: messages.length,
//               reverse: true, // Newest message at bottom
//               itemBuilder: (context, index) {
//                 ChatMessage message = messages[index];
//                 bool isMe = message.sender == "You";

//                 return Align(
//                   alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
//                   child: Slidable(
//                     key: ValueKey(message.timestamp),
//                     endActionPane: isMe
//                         ? null
//                         : ActionPane(
//                             motion: const StretchMotion(),
//                             children: [
//                               SlidableAction(
//                                 onPressed: (context) {
//                                   setState(() {
//                                     replyingTo = message; // Store reply message
//                                   });
//                                 },
//                                 backgroundColor: Colors.blue,
//                                 foregroundColor: Colors.white,
//                                 icon: Icons.reply,
//                                 label: 'Reply',
//                               ),
//                             ],
//                           ),
//                     startActionPane: isMe
//                         ? ActionPane(
//                             motion: const StretchMotion(),
//                             children: [
//                               SlidableAction(
//                                 onPressed: (context) {
//                                   setState(() {
//                                     replyingTo = message; // Store reply message
//                                   });
//                                 },
//                                 backgroundColor: Colors.green,
//                                 foregroundColor: Colors.white,
//                                 icon: Icons.reply,
//                                 label: 'Reply',
//                               ),
//                             ],
//                           )
//                         : null,
//                     child: ChatBubble(message: message, isMe: isMe),
//                   ),
//                 );
//               },
//             ),
//           ),

//           // Show the reply preview if replying
//           if (replyingTo != null)
//             Container(
//               padding: EdgeInsets.all(8),
//               color: Colors.grey.shade300,
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Text(
//                       "Replying to: ${replyingTo!.message}",
//                       style: TextStyle(fontStyle: FontStyle.italic),
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.close),
//                     onPressed: () {
//                       setState(() {
//                         replyingTo = null; // Cancel reply
//                       });
//                     },
//                   ),
//                 ],
//               ),
//             ),

//           // Chat Input Box
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: messageController,
//                     decoration: InputDecoration(
//                       labelText: "Type a message...",
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send, color: Colors.blue),
//                   onPressed: () => sendMessage(messageController.text),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Chat Bubble Widget
// class ChatBubble extends StatelessWidget {
//   final ChatMessage message;
//   final bool isMe;
//   const ChatBubble({required this.message, required this.isMe});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//       padding: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: isMe ? Colors.blue.shade100 : Colors.grey.shade300,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(10),
//           topRight: Radius.circular(10),
//           bottomLeft: isMe ? Radius.circular(10) : Radius.zero,
//           bottomRight: isMe ? Radius.zero : Radius.circular(10),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (message.replyTo != null)
//             Container(
//               padding: EdgeInsets.all(8),
//               margin: EdgeInsets.only(bottom: 4),
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade200,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Text(
//                 "Replying to: ${message.replyTo}",
//                 style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
//               ),
//             ),
//           Text(
//             message.message,
//             style: TextStyle(fontSize: 16),
//           ),
//         ],
//       ),
//     );
//   }
// }
