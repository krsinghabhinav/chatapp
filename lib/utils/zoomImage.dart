import 'package:flutter/material.dart';

class ZoomedImageScreen extends StatelessWidget {
  final String imageUrl;

  const ZoomedImageScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Hero(
            tag: 'profileImage',
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
