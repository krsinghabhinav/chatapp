import 'package:chatapp/config/contColors.dart';
import 'package:chatapp/widgets/welcometopiconwithtextname.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slide_to_act/slide_to_act.dart';
import '../../config/images.dart';
import '../../widgets/Welcomebutton.dart';

class Welcomepage extends StatefulWidget {
  const Welcomepage({super.key});

  @override
  State<Welcomepage> createState() => _WelcomepageState();
}

class _WelcomepageState extends State<Welcomepage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: Get.height * 0.06,
            ),

            // Use the constant from AssetsImages
            // Center(
            //   child: SvgPicture.asset(
            //     AssetsImages.appIconsSvg,
            //     width: 100, // Set desired width
            //     height: 100,
            //     color: Colors.amber, // Set desired height
            //   ),
            // ),
            welcometopiconwithtextname(),
            SizedBox(height: Get.height * 0.02),

            Stack(
              children: [
                Row(
                  children: [
                    Image.asset(
                      AssetsImages.boyPng,
                      height: Get.height * 0.2,
                      width: Get.width * 0.55,
                    ),
                    SizedBox(width: Get.width * 0.02),
                    Image.asset(
                      AssetsImages.girlPng,
                      height: Get.height * 0.2,
                      width: Get.width * 0.35,
                    ),
                  ],
                ),
                Positioned(
                  left: 150,
                  top: 55,
                  child: Image.asset(
                    AssetsImages.MicrophonePng,
                    height: Get.height * 0.06,
                    width: Get.width * 0.2,
                  ),
                )
              ],
            ),

            Text(
              'Now You Are',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Contcolors
                        .textColors, // Specify your desired color here
                  ),
            ),
            Text(
              'Connected',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Contcolors.textColorOrange,
                  ),
            ),

            SizedBox(height: Get.height * 0.01),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Chat with friends, family, or colleagues in real-time, share photos, videos, and more. Simple, fast, and secure messaging at your fingertips.',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Contcolors.textColors,
                      fontSize: 14,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: Get.height * 0.1),

            Welcomebutton()
          ],
        ),
      ),
    );
  }
}
