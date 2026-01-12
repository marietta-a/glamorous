import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:glamourous/routes/app_pages.dart';
import 'package:glamourous/ui/screens/wardrobe_screen.dart';

void main() {
  runApp(const MainApp());
}



class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My Wardrobe App',
      theme: ThemeData(
        primarySwatch: Colors.teal, // Example primary color
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto', // Set default font family
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black, // Ensures icons/text are visible
          elevation: 0,
        ),
      ),
      initialRoute: '/',
      getPages: AppPages.routes,
    );
  }
}
