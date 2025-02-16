import 'package:chatapp/widgets/commonButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/authController.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  final AuthController authController =
      Get.put(AuthController()); // Initialize controller

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Email Input
        Obx(() => _buildTextField(
              controller: authController.emailController.value,
              icon: Icons.alternate_email_outlined,
              hintText: "Email",
            )),
        SizedBox(height: Get.height * 0.03),

        // Password Input
        Obx(() => _buildTextField(
              controller: authController.passwordController.value,
              icon: Icons.lock_outline,
              hintText: "Password",
              obscureText: true,
            )),
        SizedBox(height: Get.height * 0.025),

        // Login Button
        // Login Button with Loading Indicator
        Obx(() {
          return authController.isloading.value
              ? CircularProgressIndicator() // Show loading indicator
              : CommonButton(
                  btnName: "LOGIN",
                  onTap: () {
                    authController.login(); // Call login method
                  },
                  color: Colors.blue,
                );
        }),
      ],
    );
  }

  // Reusable TextField Widget
  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String hintText,
    bool obscureText = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
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
}
