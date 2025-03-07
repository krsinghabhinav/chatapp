import 'dart:convert';
import 'package:chatapp/test/sqlapi/dbapisql/apiDb.dart';
import 'package:chatapp/test/sqlapi/model/productmodel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApidbcontrollerOBX extends GetxController {
  var product = Productmodel().obs; // Single Productmodel instance
  var prostore = <Map<String, dynamic>>[].obs;
  var issavedataname = false.obs;
  ApiDBHelper apidb = ApiDBHelper();

  // Fetch API data
  Future<void> getApiData() async {
    String url = "https://dummyjson.com/products";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body); // Decoding the response body
      product.value = Productmodel.fromJson(data);
    } else {
      print("Failed to load products");
    }
  }

  // Insert data into the database
  Future<void> insertstoredata({
    String? title,
    String? description,
    String? category,
    String? brand,
    String? warrantyInformation,
    String? shippingInformation,
    String? availabilityStatus,
  }) async {
    final datass = {
      "title": title,
      "description": description,
      "category": category,
      "brand": brand,
      "warrantyInformation": warrantyInformation,
      "shippingInformation": shippingInformation,
      "availabilityStatus": availabilityStatus,
    };

    // Save data if not already saved
    bool isAlreadySaved = await apidb.isSaved(title!);
    if (!isAlreadySaved) {
      await apidb.insertData(datass);
      fetapiadatasave();
    }
  }

  // Fetch saved data from the database
  Future<void> fetapiadatasave() async {
    final savefetchdata = await apidb.fetchAllData();
    prostore.assignAll(savefetchdata);
  }

  @override
  void onInit() {
    super.onInit();
    fetapiadatasave();
  }
}
