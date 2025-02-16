import 'package:chatapp/config/colors.dart';
import 'package:chatapp/config/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/contColors.dart';
import '../../widgets/welcometopiconwithtextname.dart';
import 'widget/authpagebody.dart';

class Authpage extends StatelessWidget {
  const Authpage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: Get.height * 0.1,
              ),
              welcometopiconwithtextname(),
              SizedBox(
                height: Get.height * 0.07,
              ),
              AuthPageBody(),
            ],
          ),
        ),
      ),
    );
  }
}
