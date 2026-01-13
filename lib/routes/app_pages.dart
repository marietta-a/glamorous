import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glamourous/middleware/auth_middleware.dart';
import 'package:glamourous/models/wardrobe_item.dart';
import 'package:glamourous/routes/app_routes.dart';
import 'package:glamourous/ui/screens/add_item_screen.dart';
import 'package:glamourous/ui/screens/item_details_screen.dart';
import 'package:glamourous/ui/screens/login_screen.dart';
import 'package:glamourous/ui/screens/outfit_screen.dart';
import 'package:glamourous/ui/screens/sign_up_screen.dart';
import 'package:glamourous/ui/screens/wardrobe_screen.dart';

class AppPages {
  // Define the initial route of the app
  static const INITIAL = Routes.WARDROBE;

  static final routes = [
    GetPage(
      name: Routes.LOGIN, 
      page: () => LoginScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.SIGNUP, 
      page: () => SignUpScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.WARDROBE, 
      page: () => WardrobeScreen(),
      middlewares: [AuthMiddleware()], // Protect this route
    ),
    GetPage(
      name: Routes.OUTFITS,
      page: () => OutfitScreen(),
      transition: Transition.rightToLeftWithFade, // Nice slide effect for outfits
    ),
    // Placeholders for your other screens
    GetPage(
      name: Routes.ITEM_DETAILS,
      page: (){
        final item = Get.arguments[0] as WardrobeItem;
        return ItemDetailsScreen(item: item,);
      },
      transition: Transition.rightToLeftWithFade, // Nice slide effect for outfits
    ),
    GetPage(
      name: Routes.ADD_ITEM,
      page: () => AddItemScreen(),
    ),
  ];
}