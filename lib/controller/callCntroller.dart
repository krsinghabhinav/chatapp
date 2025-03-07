// import 'package:chatapp/View/callpage/AudioCallPage.dart';
// import 'package:chatapp/model/userModel.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:uuid/uuid.dart';

// import '../View/callpage/VideoCallPage.dart';
// import '../model/CallModel.dart';

// class CallController extends GetxController {
//   final db = FirebaseFirestore.instance;
//   final auth = FirebaseAuth.instance;
//   final uuid = Uuid().v4();

//   @override
//   void onInit() {
//     getCallNotifications().listen((List<Callmodel> callerList) {
//       if (callerList.isNotEmpty) {
//         var callData = callerList[0];
//         if (callData.type == "audio") {
//           audioCallNotification(callData);
//         } else if (callData.type == "video") {
//           videoCallNotification(callData);
//         }
//       }
//     });
//     super.onInit();
//   }

//   void audioCallNotification(Callmodel callData) {
//     Get.showSnackbar(
//       GetSnackBar(
//         title: callData.callerName ?? "Unknown Caller",
//         message: "Incoming Audio Call",
//         icon: const Icon(Icons.call, color: Colors.white),
//         backgroundColor: Colors.black.withOpacity(0.8),
//         duration: const Duration(seconds: 10),
//         snackPosition: SnackPosition.TOP,
//         margin: const EdgeInsets.all(10),
//         borderRadius: 10,
//         mainButton: TextButton(
//           onPressed: () {
//             endCall(callData);
//             Get.back(); // Dismiss the snackbar
//           },
//           child: const Text(
//             "End Call",
//             style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
//           ),
//         ),
//         onTap: (_) {
//           // Open Audio Call Page when snackbar is tapped
//           Get.to(() => Audiocallpage(
//                 target: UserModel(
//                   id: callData.callerUid,
//                   name: callData.callerName,
//                   email: callData.callerEmail,
//                   profileImage: callData.callerPic,
//                 ),
//               ));
//         },
//       ),
//     );
//   }

//   void videoCallNotification(Callmodel callData) {
//     Get.showSnackbar(
//       GetSnackBar(
//         title: callData.callerName ?? "Unknown Caller",
//         message: "Incoming Video Call",
//         icon: const Icon(Icons.video_call, color: Colors.white),
//         backgroundColor: Colors.black.withOpacity(0.8),
//         duration: const Duration(seconds: 10),
//         snackPosition: SnackPosition.TOP,
//         margin: const EdgeInsets.all(10),
//         borderRadius: 10,
//         mainButton: TextButton(
//           onPressed: () {
//             endCall(callData);
//             Get.back(); // Dismiss the snackbar
//           },
//           child: const Text(
//             "End Call",
//             style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
//           ),
//         ),
//         onTap: (_) {
//           // Open Video Call Page when snackbar is tapped
//           Get.to(() => Videocallpage(
//                 target: UserModel(
//                   id: callData.callerUid,
//                   name: callData.callerName,
//                   email: callData.callerEmail,
//                   profileImage: callData.callerPic,
//                 ),
//               ));
//         },
//       ),
//     );
//   }

//   Future<void> callAcation(
//       UserModel receiver, UserModel caller, String type) async {
//     String id = uuid;

//     var newCall = Callmodel(
//       id: id,
//       callerName: caller.name,
//       callerPic: caller.profileImage,
//       callerEmail: caller.email,
//       callerUid: caller.id,
//       receiverName: receiver.name,
//       receiverEmail: receiver.email,
//       receiverPic: receiver.profileImage,
//       receiverUid: receiver.id,
//       type: type,
//       status: "dialing",
//       time: Timestamp.now().toDate().toIso8601String(),
//       timestamp: Timestamp.now().toDate().toIso8601String(),
//     );

//     try {
//       await db
//           .collection("notification")
//           .doc(receiver.id)
//           .collection("call")
//           .doc(id)
//           .set(newCall.toJson());

//       await db
//           .collection("users")
//           .doc(auth.currentUser!.uid)
//           .collection("calls")
//           .doc(id)
//           .set(newCall.toJson());

//       await db
//           .collection("users")
//           .doc(receiver.id)
//           .collection("calls")
//           .doc(id)
//           .set(newCall.toJson());

//       Future.delayed(Duration(seconds: 20), () {
//         endCall(newCall);
//       });
//     } on Exception catch (e) {
//       print("Error occurred: $e");
//     }
//   }

//   Stream<List<Callmodel>> getCallNotifications() {
//     return db
//         .collection("notification")
//         .doc(auth.currentUser!.uid)
//         .collection("call")
//         .snapshots()
//         .map((snapshot) {
//       return snapshot.docs
//           .map((doc) => Callmodel.fromJson(doc.data()))
//           .toList();
//     });
//   }

//   Future<void> endCall(Callmodel call) async {
//     try {
//       await db
//           .collection("notification")
//           .doc(call.receiverUid)
//           .collection("call")
//           .doc(call.id)
//           .delete();
//     } on Exception catch (e) {
//       print("Error deleting call: $e");
//     }
//   }
// }

import 'package:chatapp/View/callpage/AudioCallPage.dart';
import 'package:chatapp/model/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../View/callpage/VideoCallPage.dart';
import '../model/CallModel.dart';

class CallController extends GetxController {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final uuid = Uuid();

  @override
  void onInit() {
    getCallNotifications().listen((List<Callmodel> callerList) {
      if (callerList.isNotEmpty) {
        var callData = callerList[0];
        if (callData.type == "audio") {
          audioCallNotification(callData);
        } else if (callData.type == "video") {
          videoCallNotification(callData);
        }
      }
    });
    super.onInit();
  }

  /// Function to Make an Audio or Video Call
  Future<void> callAction(
      UserModel receiver, UserModel caller, String type) async {
    String id = uuid.v4(); // Ensuring unique ID for each call

    var newCall = Callmodel(
      id: id,
      callerName: caller.name,
      callerPic: caller.profileImage,
      callerEmail: caller.email,
      callerUid: caller.id,
      receiverName: receiver.name,
      receiverEmail: receiver.email,
      receiverPic: receiver.profileImage,
      receiverUid: receiver.id,
      type: type,
      status: "dialing",
      time: Timestamp.now().toDate().toIso8601String(),
      timestamp: Timestamp.now().toDate().toIso8601String(),
    );

    try {
      // Save the call in both sender's and receiver's history
      await db
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection("calls")
          .doc(id)
          .set(newCall.toJson());
      await db
          .collection("users")
          .doc(receiver.id)
          .collection("calls")
          .doc(id)
          .set(newCall.toJson());

      // Also store in the notification section for the receiver
      await db
          .collection("notification")
          .doc(receiver.id)
          .collection("call")
          .doc(id)
          .set(newCall.toJson());

      // Auto-end the call after 20 seconds if no action
      Future.delayed(const Duration(seconds: 20), () {
        endCall(newCall);
      });
    } on Exception catch (e) {
      print("Error occurred: $e");
    }
  }

  /// Function to Get All Calls for the User (Both Incoming & Outgoing)
  Stream<List<Callmodel>> getCalls() {
    return db
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("calls")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Callmodel.fromJson(doc.data()))
          .toList();
    });
  }

  /// Function to Get Call Notifications
  Stream<List<Callmodel>> getCallNotifications() {
    return db
        .collection("notification")
        .doc(auth.currentUser!.uid)
        .collection("call")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Callmodel.fromJson(doc.data()))
          .toList();
    });
  }

  Future<void> endCall(Callmodel call) async {
    try {
      await db
          .collection("notification")
          .doc(call.receiverUid)
          .collection("call")
          .doc(call.id)
          .delete();
    } on Exception catch (e) {
      print("Error deleting call: $e");
    }
  }

  /// Function to Delete All Calls from a Specific User
  Future<void> deleteAllCallsFromUser(String userId) async {
    try {
      var calls = await db
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection("calls")
          .where("receiverUid", isEqualTo: userId)
          .get();
      for (var doc in calls.docs) {
        await doc.reference.delete();
      }
    } on Exception catch (e) {
      print("Error deleting all calls: $e");
    }
  }

 /// Function to Show Audio Call Notification
void audioCallNotification(Callmodel callData) {
  Get.showSnackbar(
    GetSnackBar(
      title: callData.callerName ?? "Unknown Caller",
      message: "Incoming Audio Call",
      icon: const Icon(Icons.call, color: Colors.white),
      backgroundColor: Colors.black.withOpacity(0.8),
      duration: const Duration(seconds: 10),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
      mainButton: Row(
        children: [
          TextButton(
            onPressed: () {
              Get.back(); // Close Snackbar
              Get.to(() => Audiocallpage(
                    target: UserModel(
                      id: callData.callerUid,
                      name: callData.callerName,
                      email: callData.callerEmail,
                      profileImage: callData.callerPic,
                    ),
                  ));
            },
            child: const Text(
              "Accept Call",
              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
            onPressed: () async {
              await endCall(callData);
              Get.back();
            },
            child: const Text(
              "End Call",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    ),
  );
}

/// Function to Show Video Call Notification
void videoCallNotification(Callmodel callData) {
  Get.showSnackbar(
    GetSnackBar(
      title: callData.callerName ?? "Unknown Caller",
      message: "Incoming Video Call",
      icon: const Icon(Icons.video_call, color: Colors.white),
      backgroundColor: Colors.black.withOpacity(0.8),
      duration: const Duration(seconds: 10),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
      mainButton: Row(
        children: [
          TextButton(
            onPressed: () {
              Get.back(); // Close Snackbar
              Get.to(() => Videocallpage(
                    target: UserModel(
                      id: callData.callerUid,
                      name: callData.callerName,
                      email: callData.callerEmail,
                      profileImage: callData.callerPic,
                    ),
                  ));
            },
            child: const Text(
              "Accept Call",
              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
            onPressed: () async {
              await endCall(callData);
              Get.back();
            },
            child: const Text(
              "End Call",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    ),
  );
}

}
