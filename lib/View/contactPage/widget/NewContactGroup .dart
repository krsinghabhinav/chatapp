import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewContactGroup extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTab;
  const NewContactGroup(
      {super.key, required this.icon, required this.title, this.onTab});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      child: Container(
        height: Get.height * 0.09,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            SizedBox(width: Get.width * 0.05),
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.blue,
              child: Icon(icon, color: Colors.white),
            ),
            SizedBox(width: Get.width * 0.08),
            Text(title, style: const TextStyle(fontSize: 19)),
          ],
        ),
      ),
    );
  }
}
