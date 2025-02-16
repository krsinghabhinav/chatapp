import 'package:chatapp/test/sql/sqlcontroller/sqlController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Sqlscreen extends StatelessWidget {
  final Sqlcontroller sqlContro = Get.put(Sqlcontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Data')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: sqlContro.nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: sqlContro.mobileController,
              decoration: const InputDecoration(labelText: 'Mobile'),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: sqlContro.usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                String name = sqlContro.nameController.text;
                String username = sqlContro.usernameController.text;
                String mobile = sqlContro.mobileController.text;

                // Add the user to the database
                await sqlContro.addUserData(name, username, mobile);

                // Clear the text fields
                sqlContro.nameController.clear();
                sqlContro.usernameController.clear();
                sqlContro.mobileController.clear();

                // Navigate to DetailsScreen with the user data
                // Get.to(() => DetailsScreen(
                //       name: name,
                //       username: username,
                //       mobile: mobile,
                //     ));
              },
              child: const Text('Add User'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: sqlContro.userdata.length,
                  itemBuilder: (context, index) {
                    final user = sqlContro.userdata[index];
                    return ListTile(
                      title: Text(user['name']),
                      subtitle: Text(
                        'Mobile: ${user['mobile']}\nUsername: ${user['username']}',
                      ),
                      // onTap: () {
                      //   Get.to(() => DetailsScreen(
                      //         name: user['name'],
                      //         username: user['username'],
                      //         mobile: user['mobile'],
                      //       ));
                      // },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
