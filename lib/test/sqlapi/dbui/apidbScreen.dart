import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../dbapicontroller/apidbcontroller.dart';
import '../model/productmodel.dart';
import 'apiDetailscreempage.dart';

class Apidbscreen extends StatelessWidget {
  Apidbscreen({super.key});
  final Apidbcontroller apidata = Get.put(Apidbcontroller());
  final Productmodel model = Productmodel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API DB Data"),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(Apidetailscreempage(model: model));
            },
            icon: Icon(Icons.next_plan),
          ),
        ],
      ),
      body: FutureBuilder(
        future: apidata.getApiData(),
        builder: (context, snapshort) {
          if (snapshort.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshort.hasError) {
            return Center(child: Text('Error: ${snapshort.error}'));
          } else if (snapshort.hasData) {
            final produt = snapshort.data;

            return ListView.builder(
                itemCount: produt!.products!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(produt.products![index].title.toString()),
                  );
                });
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
