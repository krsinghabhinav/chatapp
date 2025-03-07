import 'dart:convert';
import 'package:chatapp/test/sqlapi/model/productmodel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Apidbcontroller extends GetxController {
  var product = Productmodel().obs; // single Productmodel instance
  Future<Productmodel> getApiData() async {
    String url = "https://dummyjson.com/products";

    final response = await http.get(Uri.parse(url));
    print("response==== $response");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body); // Decoding the response body
      print("data==== $data");

      // Parsing the Productmodel from the response body
      product.value = Productmodel.fromJson(data);

      print("product.value==== ${product.value}");
      // Now 'product' contains the Productmodel with all the products
      return product.value; // Return the product data
    } else {
      // Handle errors if the response status code isn't 200
      print("Failed to load products");
      throw Exception('Failed to load products');
    }
  }
}
