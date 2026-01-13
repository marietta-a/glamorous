// middleware/auth_middleware.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final session = Supabase.instance.client.auth.currentSession;
    // If no session, go to login
    return session == null ? const RouteSettings(name: '/login') : null;
  }
}