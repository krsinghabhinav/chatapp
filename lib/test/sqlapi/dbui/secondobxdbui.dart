import 'package:chatapp/test/sqlapi/model/productmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../dbapicontroller/secondController.dart';
import 'seconddetailsscreen.dart';

class ApiobxScreen extends StatelessWidget {
  ApiobxScreen({super.key});
  final ApidbcontrollerOBX apidata = Get.put(ApidbcontrollerOBX());
  Productmodel modell = Productmodel();

  @override
  Widget build(BuildContext context) {
    // Calling getApiData() when the screen is loaded
    apidata.getApiData();

    return Scaffold(
      appBar: AppBar(
        title: Text("API DB Data"),
      ),
      body: Obx(() {
        // Checking if product is null or loading data
        if (apidata.product.value.products == null) {
          return Center(child: CircularProgressIndicator());
        } else {
          // Displaying the list of products
          return ListView.builder(
            itemCount: apidata.product.value.products?.length ?? 0,
            itemBuilder: (context, index) {
              final product = apidata.product.value.products![index];
              return GestureDetector(
                onTap: () {
                  // Navigate to the Seconddetailsscreen on tap
                  Get.to(Seconddetailsscreen(
                    title: product.title,
                    availabilityStatus: product.availabilityStatus,
                    brand: product.brand,
                    category: product.category,
                    description: product.description,
                    shippingInformation: product.shippingInformation,
                    warrantyInformation: product.warrantyInformation,
                  ));
                },
                child: Card(
                  child: ListTile(
                    title: Text(product.title ?? 'No Title'),
                    subtitle: Text(product.category ?? 'No Category'),
                    trailing: Text("\$${product.sku ?? 'No SKU'}"),
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
