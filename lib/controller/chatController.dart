import 'package:chatapp/controller/contactController.dart';
import 'package:chatapp/controller/profileController.dart';
import 'package:chatapp/model/chatmodel.dart';
import 'package:chatapp/model/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../model/CallModel.dart';
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
  Contactcontroller contactController = Get.put(Contactcontroller());

  /// Generates a unique chat room ID based on user IDs
  String getCreateRoomId(String targetUserId) {
    String currentUserId = auth.currentUser!.uid;

    if (currentUserId.codeUnitAt(0) > targetUserId.codeUnitAt(0)) {
      return currentUserId + targetUserId;
    } else {
      return targetUserId + currentUserId;
    }
  }

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
      await contactController.saveContact(targetUser);
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

  Stream<UserModel> getStatus(String uid) {
    return db.collection('users').doc(uid).snapshots().map((event) {
      return UserModel.fromJson(event.data()!);
    });
  }

  Stream<List<Callmodel>> getCalls() {
    return db 
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection("calls")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Callmodel.fromJson(doc.data()))
            .toList());
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
