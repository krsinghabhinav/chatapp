// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class StatusController extends GetxController with WidgetsBindingObserver {
//   var isLoading = false.obs;

//   final FirebaseAuth auth = FirebaseAuth.instance;
//   final FirebaseFirestore db = FirebaseFirestore.instance;

//   @override
//   void onInit() {
//     WidgetsBinding.instance.addObserver(this);
//     super.onInit();
//   }

//   // @override
//   // void didChangeAppLifecycleState(AppLifecycleState state) async {
//   //   super.didChangeAppLifecycleState(state);

//   //   if (auth.currentUser != null) {
//   //     String userId = auth.currentUser!.uid;
//   //     String status = '';

//   //     switch (state) {
//   //       case AppLifecycleState.resumed:
//   //         status = "Online";
//   //         break;
//   //       case AppLifecycleState.inactive:
//   //         status = "Inactive";
//   //         break;
//   //       case AppLifecycleState.paused:
//   //         status = "Offline";
//   //         break;
//   //       case AppLifecycleState.detached:
//   //         status = "Offline";
//   //         break;
//   //       case AppLifecycleState.hidden:
//   //         status = "Hidden";
//   //         break;
//   //     }

//   //     try {
//   //       await db.collection('users').doc(userId).update({"status": status});
//   //       print("Status updated to: $status");
//   //     } catch (e) {
//   //       print("Failed to update status: $e");
//   //     }
//   //   }

//   //   print("App LifeCycle State: $state");

//   //   if (auth.currentUser != null) {
//   //     await auth.currentUser!.reload();
//   //   }
//   // }

//   // @override
//   // void didChangeAppLifecycleState(AppLifecycleState state) async {
//   //   super.didChangeAppLifecycleState(state);

//   //   auth.currentUser?.let((user) async {
//   //     String userId = user.uid;
//   //     String status = switch (state) {
//   //       AppLifecycleState.resumed => "Online",
//   //       AppLifecycleState.inactive => "Inactive",
//   //       AppLifecycleState.paused => "Offline",
//   //       AppLifecycleState.detached => "Offline",
//   //       AppLifecycleState.hidden => "Hidden"
//   //     };

//   //     try {
//   //       await db.collection('users').doc(userId).update({"status": status});
//   //       print("Status updated to: $status");
//   //     } catch (e) {
//   //       print("Failed to update status: $e");
//   //     }
//   //   });

//   //   print("App LifeCycle State: $state");

//   //   auth.currentUser?.reload();
//   // }

//   @override
//   void onClose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.onClose();
//   }
// }
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../config/customMessage.dart';

// class StatusController extends GetxController with WidgetsBindingObserver {
//   var isLoading = false.obs;

//   final FirebaseAuth auth = FirebaseAuth.instance;
//   final FirebaseFirestore db = FirebaseFirestore.instance;

//   @override
//   void onInit() {
//     WidgetsBinding.instance.addObserver(this);
//     super.onInit();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) async {
//     super.didChangeAppLifecycleState(state);

//     if (auth.currentUser != null) {
//       String userId = auth.currentUser!.uid;
//       String status = "";

//       if (state == AppLifecycleState.resumed) {
//         status = "Online";
//       } else if (state == AppLifecycleState.inactive) {
//         status = "Offline";
//       } else if (state == AppLifecycleState.paused) {
//         status = "Offline";
//       } else if (state == AppLifecycleState.detached) {
//         status = "Offline";
//       } else if (state == AppLifecycleState.hidden) {
//         status = "Offline";
//       }

//       try {
//         await db.collection('users').doc(userId).update({"status": status});
//         print("Status updated to: $status");
//         successMessage('$status');
//       } catch (e) {
//         print("Failed to update status: $e");
//         errorMessage("$e");
//       }
//     }

//     print("App LifeCycle State: $state");
//     // successMessage('$state');

//     auth.currentUser?.reload();
//   }

//   @override
//   void onClose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.onClose();
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/customMessage.dart';

class StatusController extends GetxController with WidgetsBindingObserver {
  var isLoading = false.obs;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    super.onInit();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    if (auth.currentUser != null) {
      String userId = auth.currentUser!.uid;
      String status = "Offline"; // Default to Offline

      if (state == AppLifecycleState.resumed) {
        status = "Online";
      } else if (state == AppLifecycleState.inactive || 
                 state == AppLifecycleState.paused || 
                 state == AppLifecycleState.detached) {
        status = "Offline";
      }

      try {
        await db.collection('users').doc(userId).update({"status": status});
        print("Status updated to: $status");
        successMessage('Status updated: $status');
      } catch (e) {
        print("Failed to update status: $e");
        errorMessage("Error: $e");
      }
    }

    print("App Lifecycle State: $state");
    auth.currentUser?.reload();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }
}
