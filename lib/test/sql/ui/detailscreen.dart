import 'package:chatapp/test/sql/sqlcontroller/sqlController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsScreen extends StatelessWidget {
  final String name;
  final String username;
  final String mobile;

  DetailsScreen({
    required this.name,
    required this.username,
    required this.mobile,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: $name', style: TextStyle(fontSize: 18)),
            Text('Username: $username', style: TextStyle(fontSize: 18)),
            Text('Mobile: $mobile', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
