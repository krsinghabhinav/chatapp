import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/commanController.dart';

class loginsignup extends StatelessWidget {
  const loginsignup({
    super.key,
    required this.commancontroller,
  });

  final Commancontroller commancontroller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Obx(() => InkWell(
              onTap: () {
                commancontroller.isLogin.value = true;
              },
              child: Column(
                children: [
                  Text(
                    "Login",
                    style: commancontroller.isLogin.value
                        ? TextStyle(
                            fontSize: 18,
                            color: const Color.fromARGB(255, 123, 123, 126),
                            fontWeight: FontWeight.bold)
                        : TextStyle(
                            fontSize: 15,
                            color: const Color.fromARGB(255, 123, 123, 126),
                            fontWeight: FontWeight.bold),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    width: commancontroller.isLogin.value ? 60 : 0,
                    height: 3,
                    color: Colors.white,
                  )
                ],
              ),
            )),
        Obx(() => InkWell(
              onTap: () {
                commancontroller.isLogin.value = false;
              },
              child: Column(
                children: [
                  Text(
                    "Signup",
                    style: commancontroller.isLogin.value
                        ? TextStyle(
                            fontSize: 15,
                            color: const Color.fromARGB(255, 123, 123, 126),
                            fontWeight: FontWeight.bold)
                        : TextStyle(
                            fontSize: 18,
                            color: const Color.fromARGB(255, 123, 123, 126),
                            fontWeight: FontWeight.bold),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    width: commancontroller.isLogin.value ? 0 : 75,
                    height: 3,
                    color: Colors.white,
                  )
                ],
              ),
            )),
      ],
    );
  }
}
