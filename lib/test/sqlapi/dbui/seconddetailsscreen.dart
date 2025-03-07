import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../dbapicontroller/secondController.dart';

class Seconddetailsscreen extends StatefulWidget {
  final String? title;
  final String? description;
  final String? category;
  final String? brand;
  final String? warrantyInformation;
  final String? shippingInformation;
  final String? availabilityStatus;

  Seconddetailsscreen({
    super.key,
    this.title,
    this.description,
    this.category,
    this.brand,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus,
  });

  @override
  State<Seconddetailsscreen> createState() => _SeconddetailsscreenState();
}

class _SeconddetailsscreenState extends State<Seconddetailsscreen> {
  final ApidbcontrollerOBX apidata =
      Get.put(ApidbcontrollerOBX()); // Retrieve the controller

  @override
  void initState() {
    super.initState();
    // Save the data to the local database using the controller
    _saveDataLocally();
  }

  // Method to save data locally using the controller
  Future<void> _saveDataLocally() async {
    if (widget.title != null) {
      await apidata.insertstoredata(
        title: widget.title,
        description: widget.description,
        category: widget.category,
        brand: widget.brand,
        warrantyInformation: widget.warrantyInformation,
        shippingInformation: widget.shippingInformation,
        availabilityStatus: widget.availabilityStatus,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Data'),
      ),
      body: Obx(() {
        if (apidata.prostore.isEmpty) {
          return const Center(
            child: Text(
              'No saved data available',
              style: TextStyle(fontSize: 16),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: apidata.prostore.length,
            itemBuilder: (context, index) {
              final item = apidata.prostore[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ListTile(
                  title: Text(" title ===${item['title'] ?? 'No Title'}"),
                  subtitle: Text(item['description'] ?? 'No Description'),
                  trailing: Text(item['category'] ?? 'No Category'),
                  onTap: () {
                    // Add additional actions if needed
                  },
                ),
              );
            },
          );
        }
      }),
    );
  }
}
