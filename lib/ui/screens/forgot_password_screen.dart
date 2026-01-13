import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:glamourous/controllers/auth_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final AuthController authController = Get.find();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reset Password"), elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text("Enter your email to receive a password reset link."),
            const SizedBox(height: 20),
            TextField(controller: emailController, decoration: const InputDecoration(labelText: "Email")),
            const SizedBox(height: 30),
            Obx(() => authController.isLoading.value 
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () => authController.sendPasswordReset(emailController.text),
                  child: const Text("Send Link"),
                )),
          ],
        ),
      ),
    );
  }
}