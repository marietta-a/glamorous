import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:glamourous/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await dotenv.load(fileName: "assets/env/.env");

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
