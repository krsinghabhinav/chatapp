import 'package:chatapp/widgets/commonButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserUpdateprofile extends StatefulWidget {
  const UserUpdateprofile({super.key});

  @override
  State<UserUpdateprofile> createState() => _UserUpdateprofileState();
}

class _UserUpdateprofileState extends State<UserUpdateprofile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text('Update Profile'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: Get.height * 0.7,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  CircleAvatar(
                    radius: 65,
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 63,
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                      // backgroundImage:
                      //     NetworkImage('https://picsum.photos/200/300'),
                      // backgroundImage:
                      //     NetworkImage('https://picsum.photos/200/300'),
                      child: Icon(
                        Icons.image,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Personal Info",
                              style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 148, 146, 146),
                                  fontSize: 16),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        Text(
                          "Name",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        _buildTextField(
                            controller: TextEditingController(),
                            icon: Icons.person,
                            hintText: "Name"),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Text(
                          "Email Id",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        _buildTextField(
                            controller: TextEditingController(),
                            icon: Icons.alternate_email_outlined,
                            hintText: "Example@gmil.com"),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Text(
                          "Phone Numeber",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        _buildTextField(
                            controller: TextEditingController(),
                            icon: Icons.call,
                            hintText: "7525827482")
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  CommonButton(
                    btnName: "Save",
                    onTap: () {},
                    color: Colors.blue,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildTextField({
  required TextEditingController controller,
  required IconData icon,
  required String hintText,
  bool obscureText = false,
}) {
  return Container(
    height: 48,
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(10),
    ),
    child: TextField(
      controller: controller, // Connect to controller
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white70),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.black,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
      style: TextStyle(color: Colors.white),
    ),
  );
}
