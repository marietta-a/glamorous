import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glamourous/controllers/auth_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final AuthController authController = Get.find<AuthController>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final Color accentColor = const Color(0xFF26A69A);

  // 1. Define a reactive boolean for password visibility
  final RxBool isPasswordObscured = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0, 
        backgroundColor: Colors.transparent, 
        leading: const BackButton(color: Colors.black)
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text("Create Account", 
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: accentColor)),
            const SizedBox(height: 10),
            const Text("Join Glamourous and organize your style"),
            const SizedBox(height: 40),
            
            TextField(
              controller: emailController, 
              decoration: const InputDecoration(
                labelText: "Email", 
                border: OutlineInputBorder()
              )
            ),
            const SizedBox(height: 15),

            // 2. Wrap the Password TextField with Obx to react to changes
            Obx(() => TextField(
              controller: passwordController, 
              obscureText: isPasswordObscured.value, // Bind the value here
              decoration: InputDecoration(
                labelText: "Password", 
                border: const OutlineInputBorder(),
                // 3. Add a suffix icon to toggle the visibility
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordObscured.value 
                        ? Icons.visibility_off 
                        : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    isPasswordObscured.toggle(); // Toggles between true and false
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
                    minimumSize: const Size(double.infinity, 50), 
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                  ),
                  onPressed: () => authController.signUp(emailController.text, passwordController.text),
                  child: const Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 16)),
                )),
            
            // const SizedBox(height: 20),
            // const Row(children: [Expanded(child: Divider()), Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Text("OR")), Expanded(child: Divider())]),
            // const SizedBox(height: 20),

            // // Google Sign In Button
            // OutlinedButton.icon(
            //   style: OutlinedButton.styleFrom(
            //     minimumSize: const Size(double.infinity, 50), 
            //     side: BorderSide(color: Colors.grey.shade300), 
            //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
            //   ),
            //   icon: Image.network('https://upload.wikimedia.org/wikipedia/commons/c/c1/Google_Logo.png', height: 20),
            //   label: const Text("Continue with Google", style: TextStyle(color: Colors.black)),
            //   onPressed: () => authController.signInWithGoogle(),
            // ),
          ],
        ),
      ),
    );
  }
}