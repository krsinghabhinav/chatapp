import 'package:chatapp/test/sqlapi/model/productmodel.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../dbapisql/apiDb.dart'; // Import ApiDBHelper

class Apidetailscreempage extends StatefulWidget {
  final Productmodel?
      model; // The product model that will be passed to this screen.

  Apidetailscreempage({super.key, this.model});

  @override
  State<Apidetailscreempage> createState() => _ApidetailscreempageState();
}

class _ApidetailscreempageState extends State<Apidetailscreempage> {
  // Function to store the data into the local SQLite database
  Future<void> saveProductToDatabase(Productmodel product) async {
    final db = await ApiDBHelper().database; // Get the database instance

    // Loop through the products in the model and insert them into the database
    for (var prod in product.products ?? []) {
      Map<String, dynamic> productMap = {
        'title': prod.title,
        'description': prod.description,
        'category': prod.category,
        'brand': prod.brand,
        'warrantyInformation': prod.warrantyInformation,
        'shippingInformation': prod.shippingInformation,
        'availabilityStatus': prod.availabilityStatus,
      };

      // Insert data into the 'apidata' table
      await db.insert(
        'apidata',
        productMap,
        conflictAlgorithm: ConflictAlgorithm.replace, // Prevent duplicates
      );
    }

    print("Product data saved to local database.");
  }

  @override
  Widget build(BuildContext context) {
    // Display the details of the product model on the screen
    return Scaffold(
      appBar: AppBar(
        title: Text("Details Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.model?.products?.first.title ?? "No Title",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(widget.model?.products?.first.description ?? "No Description"),
            SizedBox(height: 10),
            Text(
                "Category: ${widget.model?.products?.first.category ?? 'No Category'}"),
            SizedBox(height: 10),
            Text("Brand: ${widget.model?.products?.first.brand ?? 'No Brand'}"),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // When the save button is pressed, call the saveProductToDatabase function
                saveProductToDatabase(widget.model!);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Product saved to database")));
              },
              child: Text('Save to Database'),
            ),
          ],
        ),
      ),
    );
  }
}
