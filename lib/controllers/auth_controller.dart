import 'package:get/get.dart';
import 'package:glamourous/routes/app_routes.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  final SupabaseClient _client = Supabase.instance.client;
  
  // Observable user and session
  var currentUser = Rxn<User>();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Listen to auth state changes (login/logout)
    _client.auth.onAuthStateChange.listen((data) {
      final Session? session = data.session;
      currentUser.value = session?.user;
    });
  }

  // --- Sign Up ---
  Future<void> signUp(String email, String password) async {
    try {
      isLoading.value = true;
      await _client.auth.signUp(email: email, password: password);
      Get.snackbar("Success", "Account created! Please confirm your email.");
      Get.toNamed(Routes.LOGIN); // Return to Login
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Google Sign In Logic
  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;

      // 1. Configure Google Sign In (Replace with your actual Web Client ID from Google Console)
      const webClientId = 'YOUR_WEB_CLIENT_ID_FROM_GOOGLE_CONSOLE.apps.googleusercontent.com';
      const iosClientId = 'YOUR_IOS_CLIENT_ID_FROM_GOOGLE_CONSOLE.apps.googleusercontent.com';

      final GoogleSignIn googleSignIn = GoogleSignIn.instance;
      
      await googleSignIn.initialize(
        clientId: iosClientId,
        serverClientId: webClientId,
      );

      final googleUser = await googleSignIn.authenticate();
      final googleAuth = googleUser.authentication;
      // final accessToken = googleAuth?.accessToken;
      final idToken = googleAuth.idToken;

      if (idToken == null) throw 'No ID Token found.';

      // 2. Pass the token to Supabase
      await _client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        // accessToken: accessToken,
      );

      Get.offAllNamed(Routes.WARDROBE);
    } catch (e) {
      Get.snackbar("Google Login Failed", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // --- Sign In ---
  Future<void> signIn(String email, String password) async {
    try {
      isLoading.value = true;
      await _client.auth.signInWithPassword(email: email, password: password);
      Get.offAllNamed('/wardrobe'); // Redirect to home
    } catch (e) {
      Get.snackbar("Login Failed", "Invalid email or password");
    } finally {
      isLoading.value = false;
    }
  }

  // --- Sign Out ---
  Future<void> signOut() async {
    try{
      await _client.auth.signOut();
      Get.offAllNamed('/login');
    }
    catch(err){
      Get.snackbar("Error", "Failed to log out: ${err.toString()}");
    }
  }
}