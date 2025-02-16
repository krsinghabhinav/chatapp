import 'package:chatapp/View/Auth/widget/signupForm.dart';
import 'package:chatapp/widgets/commonButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/commanController.dart';
import 'LoginForm.dart';
import 'loginsignup.dart';

class AuthPageBody extends StatelessWidget {
  AuthPageBody({
    super.key,
  });
  Commancontroller commancontroller = Get.put(Commancontroller());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.9,
      decoration: BoxDecoration(
        color: const Color.fromARGB(221, 53, 52, 52),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          SizedBox(
            height: Get.height * 0.025,
          ),
          loginsignup(commancontroller: commancontroller),
          Obx(() => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                child:
                    commancontroller.isLogin.value ? LoginForm() : SignupForm(),
              )),
          // Obx(() => CommonButton(
          //       onTap: () {
          //         if (commancontroller.isLogin.value) {
          //           // Navigate to home page if login is successful
          //           Get.offAllNamed("/homePage");
          //         }
          //       },
          //       btnName: commancontroller.isLogin.value ? "LOGIN" : "SIGNUP",
          //       icon: commancontroller.isLogin.value
          //           ? Icons.login_outlined
          //           : Icons.lock,
          //       color: Colors.blue,
          //     )),
          // SizedBox(
          //   height: Get.height * 0.025,
          // ),
        ],
      ),
    );
  }
}
