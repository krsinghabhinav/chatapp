import 'package:chatapp/View/Auth/authpage.dart';
import 'package:chatapp/View/home/HomePageScreen.dart';
import 'package:chatapp/View/chat/ChatpageDetails.dart';
import 'package:chatapp/View/splashView/splashScreen.dart';
import 'package:chatapp/View/welcome/welcomepage.dart';
import 'package:get/get.dart';

import '../View/ProfilePage/profilePage_screen.dart';
import '../View/UserProfile/userprofile_screen.dart';
import '../View/UserProfile/UserupdateProfile.dart';
import '../View/contactPage/contact_screen.dart';

var pagePath = [
  // Auth Page
  GetPage(
    name: "/authPage",
    page: () => Authpage(),
    transition: Transition.downToUp,
    transitionDuration: Duration(milliseconds: 500),
  ),
  // Home Page
  GetPage(
    name: "/homePage",
    page: () => HomePageScreen(),
    transition: Transition.leftToRight,
    transitionDuration: Duration(milliseconds: 500),
  ),
  // Chat Page
  // GetPage(
  //   name: "/chatPageDetails",
  //   page: () => ChatpageDetails(),
  //   transition: Transition.rightToLeft,
  //   transitionDuration: Duration(milliseconds: 500),
  // ),
  // Splash Page
  GetPage(
    name: "/splashPage",
    page: () => SplashScreen(),
    transition: Transition.fadeIn,
    transitionDuration: Duration(milliseconds: 500),
  ),
  GetPage(
    name: "/userProfile",
    page: () => UserprofileScreen(),
    transition: Transition.fadeIn,
    transitionDuration: Duration(milliseconds: 500),
  ),
  GetPage(
    name: "/welcomePage",
    page: () => Welcomepage(),
    transition: Transition.fadeIn,
    transitionDuration: Duration(milliseconds: 500),
  ),
  GetPage(
    name: "/UserupdateProfile",
    page: () => UserUpdateprofile(),
    transition: Transition.fadeIn,
    transitionDuration: Duration(milliseconds: 500),
  ),
  GetPage(
    name: "/profilePage",
    page: () => ProfilepageScreen(),
    transition: Transition.fadeIn,
    transitionDuration: Duration(milliseconds: 500),
  ),
  GetPage(
    name: "/contactPage",
    page: () => ContactScreen(),
    transition: Transition.fadeIn,
    transitionDuration: Duration(milliseconds: 500),
  ),
];
