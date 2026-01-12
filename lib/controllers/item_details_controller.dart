import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glamourous/models/wardrobe_item.dart';

class ItemDetailsController extends GetxController {
  // Text Controllers
  final nameController = TextEditingController();
  final subCategoryController = TextEditingController();
  
  // Selection States
  var selectedCategory = ''.obs;
  var selectedOccasions = <String>[].obs;
  var selectedFormality = ''.obs;
  var primaryColorName = 'White'.obs;

  // Initialize values from the WardrobeItem model
  void initItem(WardrobeItem item) {
    nameController.text = item.name;
    subCategoryController.text = item.subCategory ?? "";
    selectedCategory.value = item.category;
    selectedFormality.value = item.formality ?? "Casual";
    primaryColorName.value = item.primaryColor ?? "White";
    
    if (item.occasionSuitability != null) {
      selectedOccasions.assignAll(item.occasionSuitability!);
    }
  }

  void toggleOccasion(String value) {
    if (selectedOccasions.contains(value)) {
      selectedOccasions.remove(value);
    } else {
      selectedOccasions.add(value);
    }
  }

  void setFormality(String value) => selectedFormality.value = value;

  @override
  void onClose() {
    nameController.dispose();
    subCategoryController.dispose();
    super.onClose();
  }
}