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
          children: [
            Text(
              "Glamourous", 
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: accentColor)
            ),
            const SizedBox(height: 40),
            
            TextField(
              controller: emailController, 
              decoration: const InputDecoration(labelText: "Email")
            ),
            
            // 2. Wrap the Password TextField with Obx
            Obx(() => TextField(
              controller: passwordController, 
              obscureText: isPasswordObscured.value, // Bind the value
              decoration: InputDecoration(
                labelText: "Password",
                // 3. Add the toggle icon
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordObscured.value 
                        ? Icons.visibility_off 
                        : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    isPasswordObscured.toggle(); // Switch the state
                  },
                ),
              ),
            )),
            
            const SizedBox(height: 30),
            
            Obx(() => authController.isLoading.value 
              ? CircularProgressIndicator(color: accentColor)
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
            
            TextButton(
              onPressed: () => Get.toNamed(Routes.SIGNUP),
              child: Text(
                "Don't have an account? Sign Up", 
                style: TextStyle(color: accentColor)
              ),
            )
          ],
        ),
      ),
    );
  }
}