// // import 'package:chatapp/model/chatmodel.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:get/get.dart';
// // import 'package:uuid/uuid.dart';

// // class Chatcontroller extends GetxController {
// //   final auth = FirebaseAuth.instance;
// //   final db = FirebaseFirestore.instance;
// //   var isLoading = false.obs;

// //   var uuid = Uuid();
// //   String getCreateRoomId(String targetUserId) {
// //     String currentUserId = auth.currentUser!.uid;

// //     if (currentUserId[0].codeUnitAt(0) > targetUserId[0].codeUnitAt(0)) {
// //       return currentUserId + targetUserId;
// //     } else {
// //       return targetUserId + currentUserId;
// //     }
// //   }

// //   Future<void> sendMessage(String targetUserId, String message) async {
// //     isLoading.value = true;
// //     String roomId = getCreateRoomId(targetUserId);
// //     String chatid = uuid.v4();

// //     var newChat = Chatmodel(message: message, id: chatid);
// //     try {
// //       await db
// //           .collection("chats")
// //           .doc(roomId)
// //           .collection("messages")
// //           .doc(chatid)
// //           .set(newChat.toJson());
// //     } on Exception catch (e) {
// //       print(e);
// //     } finally {
// //       isLoading.value = false;
// //     }
// //   }
// // }

// import 'package:chatapp/model/chatmodel.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:uuid/uuid.dart';

// class Chatcontroller extends GetxController {
//   final auth = FirebaseAuth.instance;
//   final db = FirebaseFirestore.instance;
//   var isLoading = false.obs;
//   var uuid = Uuid();

//   /// Generates a unique room ID based on the current user and target user
//   String getCreateRoomId(String targetUserId) {
//     String currentUserId = auth.currentUser!.uid;
//     List<String> ids = [currentUserId, targetUserId];
//     ids.sort(); // Ensures same room ID for both users
//     return ids.join("_");
//   }

//   /// Sends a message to Firestore
//   Future<void> sendMessage(String targetUserId, String message) async {
//     if (message.trim().isEmpty) return; // Prevent sending empty messages

//     isLoading.value = true;
//     String currentUserId = auth.currentUser!.uid;
//     String roomId = getCreateRoomId(targetUserId);
//     String chatId = uuid.v4(); // Unique message ID

//     var newChat = Chatmodel(
//       id: chatId,
//       message: message,
//       senderId: currentUserId, // Fix: Use the sender's ID
//       timestamp: Timestamp.now().toDate().toIso8601String(), // Ensure timestamp is stored
//     );

//     try {
//       await db
//           .collection("chats")
//           .doc(roomId)
//           .collection("messages")
//           .doc(chatId)
//           .set(newChat.toJson());

//       print("Message sent successfully!");
//     } catch (e) {
//       print("Error sending message: $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }

import 'package:chatapp/controller/profileController.dart';
import 'package:chatapp/model/chatmodel.dart';
import 'package:chatapp/model/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../model/chatRoomModel.dart';

class Chatcontroller extends GetxController {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  var isLoading = false.obs;
  var message = " ".obs;
  var selectedImagePath = " ".obs;
  var chatImageUrl = " ".obs;
  var uuid = Uuid();
  ProfileController profileController = Get.put(ProfileController());
  var ourchatRoomList = <ChatRoomModel>[].obs;

  /// Generates a unique chat room ID based on user IDs
  String getCreateRoomId(String targetUserId) {
    String currentUserId = auth.currentUser!.uid;

    if (currentUserId.codeUnitAt(0) > targetUserId.codeUnitAt(0)) {
      return currentUserId + targetUserId;
    } else {
      return targetUserId + currentUserId;
    }
  }

  // /// Sends a message to Firestore
  // Future<void> sendMessage(
  //   String targetUserId,
  //   String message,
  //   UserModel targetUser,
  // ) async {
  //   if (message.trim().isEmpty) {
  //     return;
  //   }
  //   ; // Prevent sending empty messages

  //   isLoading.value = true;
  //   String currentUserId = auth.currentUser!.uid;
  //   String roomId = getCreateRoomId(targetUserId);
  //   String chatId = uuid.v4();

  //   // Unique message ID

  //   if (selectedImagePath.value.isNotEmpty) {
  //     chatImageUrl.value = (await profileController
  //             .uploadImageToFirebaseStorage(selectedImagePath.value)) ??
  //         "";
  //   }

  //   var newChat = Chatmodel(
  //     id: chatId,
  //     message: message,
  //     senderId: currentUserId, // Sender is the current user
  //     timestamp: Timestamp.now().toDate().toIso8601String(),
  //     senderName: profileController.currentUser.value.name,
  //     receiverId: targetUserId,
  //     imageUrl: chatImageUrl.value,
  //   );
  //   print("chatimageurl======${chatImageUrl.value}");
  //   var roomDetails = ChatRoomModel(
  //     id: roomId,
  //     lastMessage: message,
  //     lastMessageTimestamp: Timestamp.now().toDate().toIso8601String(),
  //     sender: profileController.currentUser.value,
  //     receiver: targetUser,
  //     timestamp: DateTime.now().toString(),
  //     unReadMessNo: 0,
  //   );
  //   try {
  //     await db
  //         .collection("chats")
  //         .doc(roomId)
  //         .collection("messages")
  //         .doc(chatId)
  //         .set(newChat.toJson());
  //     await db.collection("chats").doc(roomId).set(
  //           roomDetails.toJson(),
  //         );

  //     print("senderName===  ${profileController.currentUser.value.name}");
  //     print("Message sent successfully!");
  //   } catch (e) {
  //     print("Error sending message: $e");
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  // Future<void> sendMessage(
  //   String targetUserId,
  //   String message,
  //   UserModel targetUser,
  // ) async {
  //   if (message.trim().isEmpty && selectedImagePath.value.isEmpty) {
  //     return;
  //   }

  //   isLoading.value = true;
  //   String currentUserId = auth.currentUser!.uid;
  //   String roomId = getCreateRoomId(targetUserId);
  //   String chatId = uuid.v4();

  //   // Upload image if selected
  //   if (selectedImagePath.value.isNotEmpty) {
  //     chatImageUrl.value = (await profileController
  //             .uploadImageToFirebaseStorage(selectedImagePath.value)) ??
  //         "";
  //   }

  //   var newChat = Chatmodel(
  //     id: chatId,
  //     message: message,
  //     senderId: currentUserId,
  //     timestamp: Timestamp.now().toDate().toIso8601String(),
  //     senderName: profileController.currentUser.value.name,
  //     receiverId: targetUserId,
  //     imageUrl: chatImageUrl.value, // Attach image URL if available
  //   );

  //   var roomDetails = ChatRoomModel(
  //     id: roomId,
  //     lastMessage: message.isNotEmpty ? message : "Photo",
  //     lastMessageTimestamp: Timestamp.now().toDate().toIso8601String(),
  //     sender: profileController.currentUser.value,
  //     receiver: targetUser,
  //     timestamp: DateTime.now().toString(),
  //     unReadMessNo: 0,
  //   );

  //   try {
  //     await db
  //         .collection("chats")
  //         .doc(roomId)
  //         .collection("messages")
  //         .doc(chatId)
  //         .set(newChat.toJson());
  //     selectedImagePath.value = " ";
  //     print("🔄 Clearing image after sending...");
  //     print("🖼️ Image Path: ${selectedImagePath.value}");
  //     await db.collection("chats").doc(roomId).set(roomDetails.toJson());

  //     print("Message sent successfully!");
  //   } catch (e) {
  //     print("Error sending message: $e");
  //   } finally {
  //     isLoading.value = false;
  //     message = "";
  //     selectedImagePath.value = "";
  //   }
  // }

  Future<void> sendMessage(
      String targetUserId, String message, UserModel targetUser) async {
    if (message.trim().isEmpty && selectedImagePath.value.isEmpty) {
      return;
    }

    isLoading.value = true;
    String currentUserId = auth.currentUser!.uid;
    String roomId = getCreateRoomId(targetUserId);
    String chatId = uuid.v4();
    String imageUrl = "";

    // Upload image if selected
    if (selectedImagePath.value.isNotEmpty) {
      imageUrl = await profileController
              .uploadImageToFirebaseStorage(selectedImagePath.value) ??
          "";
    }

    // Create message object
    var newChat = Chatmodel(
      id: chatId,
      message: message,
      senderId: currentUserId,
      timestamp: Timestamp.now().toDate().toIso8601String(),
      senderName: profileController.currentUser.value.name,
      receiverId: targetUserId,
      imageUrl: imageUrl,
    );

    var roomDetails = ChatRoomModel(
      id: roomId,
      lastMessage: message.isNotEmpty ? message : "Photo",
      lastMessageTimestamp: Timestamp.now().toDate().toIso8601String(),
      sender: profileController.currentUser.value,
      receiver: targetUser,
      timestamp: DateTime.now().toString(),
      unReadMessNo: 0,
    );

    try {
      await db
          .collection("chats")
          .doc(roomId)
          .collection("messages")
          .doc(chatId)
          .set(newChat.toJson());
      await db.collection("chats").doc(roomId).set(roomDetails.toJson());

      print("📤 Message Sent: $message | Image: $imageUrl");

      // ✅ Clear after sending
    
      selectedImagePath.value = "";
      print("🔄  Image Cleared!");
    } catch (e) {
      print("❌ Error sending message: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Stream<List<Chatmodel>> getMessages(String targetUserId) {
    String roomId = getCreateRoomId(targetUserId);
    return db
        .collection("chats")
        .doc(roomId)
        .collection("messages")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map((snapshots) {
      return snapshots.docs
          .map((doc) => Chatmodel.fromJson(doc.data()))
          .toList();
    });
  }

  // Future<void> getChatRoomList() async {
  //   List<ChatRoomModel> chatRoomList = [];
  //   await db.collection("chats").get().then((querySnapshot) {
  //     chatRoomList = querySnapshot.docs
  //         .map(
  //           (doc) => ChatRoomModel.fromJson(
  //             doc.data(),
  //           ),
  //         )
  //         .toList();
  //   });

  //   ourchatRoomList.value = chatRoomList
  //       .where(
  //         (element) => element.id!.contains(auth.currentUser!.uid),
  //       )
  //       .toList();

  //   print(chatRoomList);
  //   print(ourchatRoomList.value );
  //   print(ourchatRoomList );
  //   print(chatRoomList);
  // }

  Stream<List<ChatRoomModel>> getChatRoomList() {
    List<ChatRoomModel> chatRoomList = [];
    return db
        .collection("chats")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map((querySnapshot) {
      chatRoomList = querySnapshot.docs
          .map((doc) => ChatRoomModel.fromJson(doc.data()))
          .toList();

      String currentUserId = auth.currentUser!.uid;
      ourchatRoomList.value = chatRoomList.where((element) {
        // Ensure current user is either sender or receiver
        if (element.sender!.id == currentUserId ||
            element.receiver!.id == currentUserId) {
          return true;
        }
        return false;
      }).toList();

      print("chatRoomList=====${chatRoomList}");
      print("filteredList=====${ourchatRoomList.value}");
      return ourchatRoomList;
    });
  }

// Corrected Stream function
  // Stream<List<ChatRoomModel>> getChatRoomList() {
  //   List<ChatRoomModel> chatRoomList = [];
  //   return db.collection("chats").snapshots().map((querySnapshot) {
  //     chatRoomList = querySnapshot.docs
  //         .map((doc) => ChatRoomModel.fromJson(doc.data()))
  //         .toList();

  //     // Filter chat rooms based on current user ID
  //     ourchatRoomList.value = chatRoomList
  //         .where((element) => element.id!.contains(auth.currentUser!.uid))
  //         .toList();
  //     print("chatRoomList=====${chatRoomList}");
  //     print("filteredList=====${ourchatRoomList.value}");
  //     print("filteredList=====${ourchatRoomList}");
  //     return ourchatRoomList;
  //   });
  // }
  // @override
  // void onInit() {
  //   getChatRoomList();
  //   super.onInit();
  // }

//   Future<void> getChatRoomList() async {
//   try {
//     QuerySnapshot querySnapshot = await db.collection("chats").get();

//     List<ChatRoomModel> chatRoomList = querySnapshot.docs
//         .map((doc) => ChatRoomModel.fromJson(doc.data() as Map<String, dynamic>))
//         .where((chatRoom) => chatRoom.id!.contains(auth.currentUser!.uid))
//         .toList();

//     print(chatRoomList);
//   } catch (e) {
//     print("Error fetching chat rooms: $e");
//   }
// }

  @override
  void onInit() {
    super.onInit();
    getChatRoomList();
  }
}
