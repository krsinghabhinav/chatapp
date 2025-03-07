// // import 'package:chatapp/View/home/HomePageScreen.dart';
// // import 'package:chatapp/controller/profileController.dart';
// // import 'package:chatapp/model/groupModel.dart';
// // import 'package:chatapp/model/userModel.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:uuid/uuid.dart';

// // class Groupcontroller extends GetxController {
// //   final db = FirebaseFirestore.instance;
// //   final auth = FirebaseAuth.instance;
// //   var uuid = Uuid();
// //   ProfileController profileController = Get.put(ProfileController());
// //   TextEditingController groupNameController = TextEditingController();
// //   var isLoading = false.obs;

// //   @override
// //   void onInit() {
// //     super.onInit();
// //     getGroup(); // Fetch groups when the controller initializes
// //   }

// //   var groupList = <GroupModel>[].obs;
// //   var groupMembers = <UserModel>[].obs;

// //   void selectMember(UserModel user) {
// //     if (groupMembers.contains(user)) {
// //       groupMembers.remove(user);
// //     } else {
// //       groupMembers.add(user);
// //     }
// //   }

// //   /// **Create a New Group**
// //   Future<void> createGroup(String groupName, String imagePath) async {
// //     isLoading.value = true;
// //     String groupId = uuid.v4();
// //     String? imageUrl;

// //     try {
// //       // Upload image if provided
// //       if (imagePath.isNotEmpty) {
// //         imageUrl =
// //             await profileController.uploadImageToFirebaseStorage(imagePath);
// //       }

// //       print("createGroup imageUrl: $imageUrl");
// //       print("createGroup members: ${groupMembers.toList()}");

// //       // Create GroupModel instance
// //       // var newGroup = GroupModel(
// //       //   id: groupId,
// //       //   name: groupName,
// //       //   profileUrl: imageUrl, // Set uploaded image or null
// //       //   members: groupMembers.toList(),
// //       //   createdAt: DateTime.now().toIso8601String(),
// //       //   createBy: auth.currentUser!.uid,
// //       //   timeStamp: DateTime.now().toIso8601String(),
// //       // );

// //       // Store group in Firestore
// //       await db.collection('groups').doc(groupId).set({
// //         'id': groupId,
// //         'name': groupName,
// //         'profileUrl': imageUrl,
// //         'members': groupMembers.map((e) => e.toJson()).toList(),
// //         'createdAt': DateTime.now().toIso8601String(),
// //         'createBy': auth.currentUser!.uid,
// //         'timeStamp': DateTime.now().toIso8601String(),
// //       });
// //       getGroup();
// //       // Navigate to Home and show success message
// //       Get.snackbar('Group Created', "Group Created Successfully");
// //       Get.offAll(HomePageScreen());

// //       print("Group Name: $groupName");
// //       print("Group Members: ${groupMembers.toList()}");
// //     } catch (e) {
// //       print('Error creating group: $e');
// //     } finally {
// //       isLoading.value = false;
// //     }
// //   }

// //   Future<void> getGroup() async {
// //     isLoading.value = true;
// //     List<GroupModel> tempGroup = [];
// //     await db.collection('groups').get().then((value) {
// //       tempGroup =
// //           value.docs.map((doc) => GroupModel.fromJson(doc.data())).toList();
// //     });
// //     // groupList.clear();
// //     groupList.value = tempGroup
// //         .where((e) =>
// //             e.members!.any((element) => element.id == auth.currentUser!.uid))
// //         .toList();
// //     // Print statements to check the data
// //     print("Fetched Groups: ${tempGroup.length}");
// //     print("Fetched auth.currentUser!.uid Groups: ${auth.currentUser!.uid}");
// //     print("Filtered Groups for User: ${groupList.length}");
// //     print("Group List Data: $groupList");
// //     isLoading.value = false;
// //   }
// // }
// import 'package:chatapp/View/home/HomePageScreen.dart';
// import 'package:chatapp/controller/profileController.dart';
// import 'package:chatapp/model/groupModel.dart';
// import 'package:chatapp/model/userModel.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:uuid/uuid.dart';

// class Groupcontroller extends GetxController {
//   final db = FirebaseFirestore.instance;
//   final auth = FirebaseAuth.instance;
//   var uuid = Uuid();
//   ProfileController profileController = Get.put(ProfileController());
//   TextEditingController groupNameController = TextEditingController();
//   var isLoading = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     getGroup(); // Fetch groups when the controller initializes
//   }

//   var groupList = <GroupModel>[].obs;
//   var groupMembers = <UserModel>[].obs;

//   void selectMember(UserModel user) {
//     if (groupMembers.contains(user)) {
//       groupMembers.remove(user);
//     } else {
//       groupMembers.add(user);
//     }
//   }

//   /// **Create a New Group**
//   Future<void> createGroup(String groupName, String imagePath) async {
//     isLoading.value = true;
//     String groupId = uuid.v4();
//     String? imageUrl;

//     try {
//       // Upload image if provided
//       if (imagePath.isNotEmpty) {
//         imageUrl =
//             await profileController.uploadImageToFirebaseStorage(imagePath);
//       }

//       print("createGroup imageUrl: $imageUrl");
//       print("createGroup members: ${groupMembers.toList()}");

//       // **Current user ko bhi members list me add karein**
//       UserModel currentUser = UserModel(
//         id: auth.currentUser!.uid,
//         name: auth.currentUser!.displayName ?? 'Unknown',
//         email: auth.currentUser!.email ?? '',
//         profileImage: auth.currentUser!.photoURL ?? '',
//       );

//       if (!groupMembers.contains(currentUser)) {
//         groupMembers.add(currentUser);
//       }

//       // Store group in Firestore
//       await db.collection('groups').doc(groupId).set({
//         'id': groupId,
//         'name': groupName,
//         'profileUrl': imageUrl,
//         'members': groupMembers.map((e) => e.toJson()).toList(),
//         'createdAt': DateTime.now().toIso8601String(),
//         'createBy': auth.currentUser!.uid,
//         'timeStamp': DateTime.now().toIso8601String(),
//       });
//       getGroup();
//       // Navigate to Home and show success message
//       Get.snackbar('Group Created', "Group Created Successfully");
//       Get.offAll(HomePageScreen());

//       print("Group Name: $groupName");
//       print("Group Members: ${groupMembers.toList()}");
//     } catch (e) {
//       print('Error creating group: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   /// **Fetch Groups**
//   Future<void> getGroup() async {
//     isLoading.value = true;
//     List<GroupModel> tempGroup = [];
//     await db.collection('groups').get().then((value) {
//       tempGroup =
//           value.docs.map((doc) => GroupModel.fromJson(doc.data())).toList();
//     });

//     // **Condition ko correct kiya taaki current user ke banaye hue aur jisme vo member hai dono dikhein**
//     groupList.value = tempGroup.where((group) =>
//         group.createBy == auth.currentUser!.uid ||
//         group.members!.any((member) => member.id == auth.currentUser!.uid)).toList();

//     // Print statements to check the data
//     print("Fetched Groups: ${tempGroup.length}");
//     print("Fetched auth.currentUser!.uid Groups: ${auth.currentUser!.uid}");
//     print("Filtered Groups for User: ${groupList.length}");
//     print("Group List Data: $groupList");
//     isLoading.value = false;
//   }
// }
import 'package:chatapp/View/home/HomePageScreen.dart';
import 'package:chatapp/controller/profileController.dart';
import 'package:chatapp/model/chatmodel.dart';
import 'package:chatapp/model/groupModel.dart';
import 'package:chatapp/model/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class Groupcontroller extends GetxController {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  var uuid = Uuid();
  ProfileController profileController = Get.put(ProfileController());
  TextEditingController groupNameController = TextEditingController();
  var isLoading = false.obs;

  var groupList = <GroupModel>[].obs;
  var groupMembers = <UserModel>[].obs;
  var allUsers =
      <UserModel>[].obs; // 🔹 Yeh list Firebase ke sabhi users ko rakhegi

  @override
  void onInit() {
    super.onInit();
    getGroup();
    fetchAllUsers(); // 🔹 Firebase se sabhi users ko fetch karega
  }

  /// **Firebase se sabhi Users ko fetch karein**
  Future<void> fetchAllUsers() async {
    try {
      QuerySnapshot snapshot = await db.collection('users').get();
      List<UserModel> usersList = snapshot.docs
          .map((doc) => UserModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      allUsers.value = usersList;
      print("Fetched Users: ${allUsers.length}");
    } catch (e) {
      print("Error fetching users: $e");
    }
  }

  /// **Group Members Select/Deselect**
  void selectMember(UserModel user) {
    if (groupMembers.contains(user)) {
      groupMembers.remove(user);
    } else {
      groupMembers.add(user);
    }
  }

  /// **Group Create**
  Future<void> createGroup(String groupName, String imagePath) async {
    isLoading.value = true;
    String groupId = uuid.v4();
    String? imageUrl;

    try {
      // **Firebase me image upload karna agar diya gaya ho**
      if (imagePath.isNotEmpty) {
        imageUrl =
            await profileController.uploadImageToFirebaseStorage(imagePath);
      }

      // **Current User ko bhi groupMembers me add karna**
      // UserModel currentUser = UserModel(
      //   id: auth.currentUser!.uid,
      //   name: auth.currentUser!.displayName ?? 'Unknown',
      //   email: auth.currentUser!.email ?? '',
      //   profileImage: auth.currentUser!.photoURL ?? '',
      //   role: 'admin',
      // );

      // **Current User ko bhi groupMembers me add karna**
      UserModel currentUser = UserModel(
        id: auth.currentUser!.uid,
        name: profileController.currentUser.value.name ?? '',
        // email: auth.currentUser!.email ?? '',
        email: profileController.currentUser.value.email ?? '',
        profileImage: profileController.currentUser.value.profileImage ?? '',
        role: 'admin',
      );

      if (!groupMembers.any((member) => member.id == currentUser.id)) {
        groupMembers.add(currentUser);
      }

      // **Firestore me Group Save Karna**
      await db.collection('groups').doc(groupId).set({
        'id': groupId,
        'name': groupName,
        'profileUrl': imageUrl,
        'members': groupMembers.map((e) => e.toJson()).toList(),
        'createdAt': DateTime.now().toIso8601String(),
        'createBy': auth.currentUser!.uid,
        'timeStamp': DateTime.now().toIso8601String(),
      });

      getGroup(); // **Group fetch karne ke liye**
      Get.snackbar('Group Created', "Group Created Successfully");
      Get.offAll(HomePageScreen());

      print("Group Created: $groupName");
      print("Group Members: ${groupMembers.toList()}");
    } catch (e) {
      print('Error creating group: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// **Groups Fetch karna**
  Future<void> getGroup() async {
    isLoading.value = true;
    List<GroupModel> tempGroup = [];
    try {
      await db
          .collection('groups')
          .orderBy('timeStamp', descending: true) // 🔹 Order by descending
          .get()
          .then((value) {
        tempGroup = value.docs.map((doc) =>
            // GroupModel.fromJson(doc.data() as Map<String, dynamic>))
            GroupModel.fromJson(doc.data())).toList();
      });

      // 🔹 **Aise groups fetch karein jo current user ne banaye ho ya jisme vo member ho**
      groupList.value = tempGroup
          .where((group) =>
              group.createBy == auth.currentUser!.uid ||
              group.members!
                  .any((member) => member.id == auth.currentUser!.uid))
          .toList();

      print("Fetched Groups: ${tempGroup.length}");
      print("Groups for User: ${groupList.length}");
    } catch (e) {
      print("Error fetching groups: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteGroup(String groupId) async {
    try {
      await db.collection('groups').doc(groupId).delete();
      Get.snackbar('Group Deleted', "Group Deleted Successfully");
      getGroup();
    } catch (e) {
      print("Error deleting group: $e");
    }
  }

  Future<void> sendGroupMessage(
      String message, String groupId, String imagePath) async {
    isLoading.value = true;
    String chatID = uuid.v4();
    String? imageUrl =
        await profileController.uploadImageToFirebaseStorage(imagePath);
    var newGroupChat = Chatmodel(
      id: chatID,
      senderId: auth.currentUser!.uid,
      message: message,
      imageUrl: imageUrl,
      timestamp: DateTime.now().toIso8601String(),
      senderName: profileController.currentUser.value.name,
    );
    await db
        .collection('groups')
        .doc(groupId)
        .collection("Gmessage")
        .doc(chatID)
        .set(newGroupChat.toJson());
    isLoading.value = false;
  }

  Stream<List<Chatmodel>> getGroupMessage(String groupId) {
    return db
        .collection('groups')
        .doc(groupId)
        .collection("Gmessage")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map(
          (query) =>
              query.docs.map((doc) => Chatmodel.fromJson(doc.data())).toList(),
        );
  }

  Future<void> addGroupMember(String groupId, UserModel user) async {
    try {
      isLoading.value = true;
      await db.collection('groups').doc(groupId).update({
        'members': FieldValue.arrayUnion([user.toJson()])
        // 'members': user.toJson()
      });
      Get.snackbar('Member Added', "Member Added Successfully");
      getGroup();
      isLoading.value = false;
    } catch (e) {
      print("Error adding member: $e");
    }
  }
}
