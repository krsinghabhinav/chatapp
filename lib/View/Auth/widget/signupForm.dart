import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/authController.dart';
import '../../../controller/commanController.dart';
import '../../../widgets/commonButton.dart';
import 'LoginForm.dart';

class SignupForm extends StatelessWidget {
  SignupForm({super.key});

  final AuthController authController = Get.put(AuthController());
  final Commancontroller commonController = Get.put(Commancontroller());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Full Name Input
        Obx(() => _buildTextField(
              controller: authController.fullnameController.value,
              icon: Icons.person,
              hintText: "Full Name",
            )),
        SizedBox(height: Get.height * 0.03),

        // Email Input
        Obx(() => _buildTextField(
              controller: authController.emailController.value,
              icon: Icons.alternate_email,
              hintText: "Email",
            )),
        SizedBox(height: Get.height * 0.03),

        // Password Input
        Obx(() => _buildTextField(
              controller: authController.passwordController.value,
              icon: Icons.lock,
              hintText: "Password",
              obscureText: true,
            )),
        SizedBox(height: Get.height * 0.025),

        // Signup Button
        Obx(() => authController.isloading.value
            ? CircularProgressIndicator()
            : CommonButton(
                btnName: "SIGNUP",
                onTap: () {
                  authController.createUser();
                  // Call register method
                  commonController.isLogin.value ? LoginForm() : SignupForm();
                },
                color: Colors.blue,
              )),
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
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
