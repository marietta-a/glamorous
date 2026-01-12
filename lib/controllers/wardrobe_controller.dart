import 'package:get/get.dart';
import 'package:glamourous/models/category.dart';
import 'package:glamourous/models/wardrobe_item.dart';

// --- GetX Controller for Wardrobe State Management ---
class WardrobeController extends GetxController {

  final RxList<Category> categories = <Category>[].obs;
  final RxList<WardrobeItem> wardrobeItems = <WardrobeItem>[].obs;
  
  // Make sure this is an Rx object
  final selectedCategory = Rxn<Category>();

  @override
  void onInit() {
    super.onInit();
    // Load your data
    categories.assignAll(mockCategories);
    wardrobeItems.assignAll(mockWardrobeItems);
    selectedCategory.value = mockCategories.first;
  }
  
  final List<Category> filteredCategories = mockCategories.obs;


  void changeCategory(Category category) {
    selectedCategory.value = category;
    filterByCategory(category);
  }

  void filterByCategory(Category category){
    try{
      if(category == mockCategories.first){
        filteredCategories.assignAll(mockCategories);
        wardrobeItems.assignAll(mockWardrobeItems);
        return;
      }
      filteredCategories.assignAll(categories.where((cat) => cat.name.toLowerCase() == category.name.toLowerCase()).toList());
      wardrobeItems.assignAll(mockWardrobeItems.where((b) =>
                        filteredCategories.any((cat) => cat.name.toLowerCase() == b.category.toLowerCase())
                      ).toList());
    }
    catch(err){
      rethrow;
    }
  }
}
