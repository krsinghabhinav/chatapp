import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chatapp/config/themes.dart';
import 'package:chatapp/config/pagePathRouting.dart'; // Your page routes
import 'controller/authController.dart';
import 'controller/callCntroller.dart';
import 'controller/commanController.dart';
import 'controller/splashController.dart';
import 'firebase_options.dart'; // Firebase configuration file
import 'View/splashView/splashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(Commancontroller()); // Fix: Register missing controller
  Get.put(Splashcontroller());
  Get.put(AuthController());
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
    CallController callController = Get.put(CallController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: pagePath, // Use the pagePath for routing
      title: 'ChatApp',
      theme: lightTheme, // Define your light theme here
      darkTheme: darkTheme, // Define your dark theme here
      themeMode: ThemeMode.dark, // Set your theme mode (dark or light)
      home: SplashScreen(), // Use SplashScreen as the initial screen
    );
  }
}
