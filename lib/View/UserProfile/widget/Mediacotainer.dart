import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/contColors.dart';
import '../../../config/images.dart';

class Mediacotainer extends StatelessWidget {
  const Mediacotainer({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        height: Get.height * 0.22,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text("Media",
                  style: TextStyle(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      fontSize: 15)),
            ),
            Row(
              children: [
                Expanded(
                  // Ensure ListView takes available space
                  child: SizedBox(
                    height: Get.height * 0.15, // Define a fixed height
                    child: ListView.builder(
                      scrollDirection:
                          Axis.horizontal, // Ensure horizontal scrolling
                      itemCount: images.length, // Example count
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          // height: Get.height * 0.18,
                          width: Get.width * 0.3,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 48, 47, 47),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              images[index],
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
