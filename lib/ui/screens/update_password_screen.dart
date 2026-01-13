import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:glamourous/controllers/auth_controller.dart';

class UpdatePasswordScreen extends StatelessWidget {

  UpdatePasswordScreen({super.key});

  final AuthController authController = Get.find();
  final passwordController = TextEditingController();
  final RxBool isObscured = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Create New Password", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            Obx(() => TextField(
              controller: passwordController,
              obscureText: isObscured.value,
              decoration: InputDecoration(
                labelText: "New Password",
                suffixIcon: IconButton(
                  icon: Icon(isObscured.value ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => isObscured.toggle(),
                ),
              ),
            )),
            const SizedBox(height: 30),
            Obx(() => authController.isLoading.value 
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () => authController.updatePassword(passwordController.text),
                  child: const Text("Update Password"),
                )),
          ],
        ),
      ),
    );
  }
}