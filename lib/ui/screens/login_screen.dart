import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glamourous/controllers/auth_controller.dart';
import 'package:glamourous/routes/app_routes.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  
  final AuthController authController = Get.put(AuthController());
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final Color accentColor = const Color(0xFF26A69A);

  // 1. Define the reactive boolean for password visibility
  final RxBool isPasswordObscured = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Glamourous", 
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: accentColor)
            ),
            const SizedBox(height: 40),
            
            TextField(
              controller: emailController, 
              decoration: const InputDecoration(labelText: "Email")
            ),
            
            const SizedBox(height: 16),
            
            Obx(() => TextField(
              controller: passwordController, 
              obscureText: isPasswordObscured.value,
              decoration: InputDecoration(
                labelText: "Password",
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordObscured.value 
                        ? Icons.visibility_off 
                        : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    isPasswordObscured.toggle();
                  },
                ),
              ),
            )),
            
            const SizedBox(height: 30),
            
            Obx(() => authController.isLoading.value 
              ? Center(child: CircularProgressIndicator(color: accentColor))
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor, 
                    minimumSize: const Size(double.infinity, 50)
                  ),
                  onPressed: () => authController.signIn(
                    emailController.text, 
                    passwordController.text
                  ),
                  child: const Text("Log In", style: TextStyle(color: Colors.white)),
                )),
            
            Center(
              child: TextButton(
                onPressed: () => Get.toNamed(Routes.FORGOT_PASSWORD),
                child: Text("Forgot Password?", style: TextStyle(color: accentColor)),
              ),
            ),

            Center(
              child: TextButton(
                onPressed: () => Get.toNamed(Routes.SIGNUP),
                child: Text(
                  "Don't have an account? Sign Up", 
                  style: TextStyle(color: accentColor)
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}