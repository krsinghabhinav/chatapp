// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:get/get.dart';
// import 'package:listing_provider/src/routes/app_routes.dart';

// class InternetConnctivityController extends GetxController {
//   var isConnected = true.obs;
//   final Connectivity _connectivity = Connectivity();

//   @override
//   void onInit() {
//     super.onInit();
//     _connectivity.onConnectivityChanged
//         .listen((List<ConnectivityResult> results) {
//       if (results.isNotEmpty && results.contains(ConnectivityResult.none)) {
//         //update status
//         _updateConectionStatus(ConnectivityResult.none);
//       } else {
//         _updateConectionStatus(results.first);
//       }
//     });
//     checkInitialConnection();
//   }

//   Future<void> checkInitialConnection() async {
//     try {
//       final List<ConnectivityResult> results =
//           await _connectivity.checkConnectivity();
//       if (results.isNotEmpty && results.contains(ConnectivityResult.none)) {
//         _updateConectionStatus(ConnectivityResult.none);
//       } else {
//         _updateConectionStatus(results.first);
//       }
//     } catch (e) {
//       print('Error=> $e');
//     }
//   }

//   void _updateConectionStatus(ConnectivityResult result) {
//     if (result == ConnectivityResult.none) {
//       if (isConnected.value) {
//         isConnected.value = false;
//         //offline page
//         Get.toNamed(AppRoutes.offlineScreen);
//         _retureToLastScreen();
//       }
//     } else {
//       if (!isConnected.value) {
//         isConnected.value = true;
//         //onlinepage
//         Get.toNamed(AppRoutes.onlineScreen);
//         _retureToLastScreen();
//       }
//     }
//   }

//   void _retureToLastScreen() {
//     Get.back(canPop: true);
//   }

//   Future<void> checkAndRetry() async {
//     await Future.delayed(Duration(milliseconds: 500));
//     final List<ConnectivityResult> results =
//         await _connectivity.checkConnectivity();
//     if (results.isNotEmpty && results.contains(ConnectivityResult.none)) {
//       isConnected.value = true;
//       update();
//       _retureToLastScreen();
//     } else {
//       Get.snackbar("No Connection Found", " Still not Connected");
//     }
//   }
// }

import 'package:chatapp/features/internet_connectivity/screen/offline_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class InternetConnectivityController extends GetxController {
  var isConnected = true.obs;
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      if (results.isNotEmpty && results.contains(ConnectivityResult.none)) {
        _updateConnectionStatus(ConnectivityResult.none);
      } else {
        _updateConnectionStatus(results.first);
      }
    });
    checkInitialConnection();
  }

  Future<void> checkInitialConnection() async {
    try {
      final List<ConnectivityResult> results =
          await _connectivity.checkConnectivity();
      if (results.isNotEmpty && results.contains(ConnectivityResult.none)) {
        _updateConnectionStatus(ConnectivityResult.none);
      } else {
        _updateConnectionStatus(results.first);
      }
    } catch (e) {
      print('Error => $e');
    }
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      if (isConnected.value) {
        isConnected.value = false;
        Get.to(OfflineScreen());
      }
    } else {
      if (!isConnected.value) {
        isConnected.value = true;
        // Get.toNamed(AppRoutes.onlineScreen);
        _returnToLastScreen();
      }
    }
  }

  void _returnToLastScreen() {
    // if (Get.currentRoute != AppRoutes.onlineScreen && Get.currentRoute != AppRoutes.offlineScreen) {
    Get.back(canPop: true);
    // }
  }

  Future<void> checkAndRetry() async {
    await Future.delayed(Duration(milliseconds: 300));
    final List<ConnectivityResult> results =
        await _connectivity.checkConnectivity();
    if (results.isNotEmpty && !results.contains(ConnectivityResult.none)) {
      isConnected.value = true;
      update();
      _returnToLastScreen();
    } else {
      Get.snackbar("No Connection Found", "Still not Connected");
    }
  }

  // AIzaSyDghL92ivphOdQHzoyik5M-vfdJZFcAFYw
}
