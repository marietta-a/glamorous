import 'dart:math';
import 'package:get/get.dart';
import 'package:glamourous/models/wardrobe_item.dart';

class OutfitController extends GetxController {
  // Observables for the 4 slots
  var top = Rxn<WardrobeItem>();
  var accessory = Rxn<WardrobeItem>();
  var bottom = Rxn<WardrobeItem>();
  var shoes = Rxn<WardrobeItem>();

  @override
  void onInit() {
    super.onInit();
    generateRandomOutfit();
  }

  void generateRandomOutfit() {
    final random = Random();

    // Helper to pick random item by category
    WardrobeItem? getRandom(String category) {
      var items = mockWardrobeItems.where((i) => i.category == category).toList();
      return items.isNotEmpty ? items[random.nextInt(items.length)] : null;
    }

    top.value = getRandom('Tops');
    accessory.value = getRandom('Accessories');
    bottom.value = getRandom('Bottoms');
    shoes.value = getRandom('Shoes');
  }
}