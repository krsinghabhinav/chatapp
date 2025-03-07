import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../View/Auth/authpage.dart';
import '../View/home/homepage.dart';
import '../config/contColors.dart';

class Welcomebutton extends StatelessWidget {
  const Welcomebutton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: SlideAction(
        onSubmit: () {
          // Navigate to the homepage
          // Future.delayed(Duration(milliseconds: 200), () {
          //   Get.to(Authpage()); // Replace with your route name
          // });

          Get.offAllNamed("/authPage");
        },
        sliderRotate: true,
        text: "Slide for login/singup",
        textStyle: const TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.normal,
        ),
        animationDuration: Duration(seconds: 1),
        submittedIcon: const Icon(
          Icons.done_all,
          color: Colors.white,
          size: 30,
        ),

        sliderButtonIcon: const Icon(
          Icons.arrow_forward,
          size: 10,
          color: Contcolors.textColorOrange,
        ),

        reversed: false,
        height: Get.height * 0.07,
        sliderButtonIconSize: 10,
        // innerColor: ,
        outerColor: Contcolors.textColorOrange,
        // sliderButtonIcon: Icon(Icons.arr),
      ),
    );
  }
}
