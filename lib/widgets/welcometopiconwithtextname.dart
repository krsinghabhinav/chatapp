import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/contColors.dart';
import '../config/images.dart';

class welcometopiconwithtextname extends StatelessWidget {
  const welcometopiconwithtextname({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Image.asset(
            AssetsImages.appiconPng,
            height: Get.height * 0.13,
            width: Get.width * 0.3,
          ),
        ),
        SizedBox(
          height: Get.height * 0.015,
        ),
        Text(
          'SAMPARK',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: Contcolors
                    .textColorOrange, // Specify your desired color here
              ),
        ),
      ],
    );
  }
}
