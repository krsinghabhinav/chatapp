import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chatapp/config/themes.dart';
import 'package:chatapp/config/pagePathRouting.dart'; // Your page routes
import 'package:get_storage/get_storage.dart';

import 'features/internet_connectivity/controller/internet_connctivity_controller.dart';
import 'firebase_options.dart'; // Firebase configuration file
import 'View/splashView/splashScreen.dart';

void main() async {
  await GetStorage.init();
  Get.put(InternetConnectivityController(), permanent: true);
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

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
