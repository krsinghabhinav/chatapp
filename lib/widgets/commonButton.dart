import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonButton extends StatelessWidget {
  final String btnName;
  final Color? color;
  final VoidCallback onTap;
  final String? imagePath; // Dynamic image path
  final IconData? icon; // Dynamic icon

  const CommonButton({
    Key? key,
    required this.btnName,
    this.color,
    required this.onTap,
    this.imagePath,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Handle button click
      child: Container(
        height: Get.height * 0.055,
        width: Get.width * 0.3,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Align items properly
          children: [
            if (imagePath != null) // Check if image path is provided
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Image.asset(
                  imagePath!,
                  height: 36,
                ),
              ),
            if (icon != null) // Only show the icon if provided
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(icon, color: Colors.white),
              ),
            SizedBox(
              width: Get.width * 0.03,
            ),
            Text(
              btnName,
              style: const TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 233, 233, 236),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
