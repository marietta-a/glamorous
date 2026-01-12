// --- My Wardrobe Screen Widget ---
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glamourous/controllers/wardrobe_controller.dart';
import 'package:glamourous/models/category.dart';

class WardrobeScreen extends StatefulWidget {
  const WardrobeScreen({super.key});
  
  @override
  State<StatefulWidget> createState() => _WardrobeScreenState();
}

class _WardrobeScreenState extends State<WardrobeScreen> {
  // Initialize the controller
  final WardrobeController controller = Get.put(WardrobeController());
  int selectedIndex = 0;

  // Define accent color for consistency
  final Color accentColor = Colors.teal; // Example teal, adjust as desired

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            // Handle hamburger menu press (e.g., open drawer)
          },
        ),
        title: const Text(
          'My Wardrobe',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto', // Or your chosen sans-serif font
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Handle Add Item (+) button press
                Get.toNamed('/addItem'); // Example navigation
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.zero, // Remove default padding
                minimumSize: const Size(40, 40), // Set specific size
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 24),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Tabs
          Container(
            height: 60,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Obx(() => ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.categories.length,
                itemBuilder: (context, index) {
                  Category category = controller.categories[index];
                  return GestureDetector(
                    onTap: (){
                      controller.changeCategory(category);
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: selectedIndex == index  ? accentColor.withOpacity(0.15) : Colors.transparent,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                            color: selectedIndex == index ? accentColor : Colors.transparent, width: 1.0),
                      ),
                      child: Text(
                        category.name,
                        style: TextStyle(
                          color: selectedIndex == index  ? accentColor : Colors.grey[700],
                          fontWeight: selectedIndex == index  ? FontWeight.bold : FontWeight.normal,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
                  );
                },
              )
            ),
          ),
          const Divider(height: 1, color: Colors.grey), // Separator below tabs
          // Wardrobe Items Grid
          Expanded(
            child: Obx( () =>  GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.85, // Adjust to make cards slightly taller for text
              ),
              itemCount: controller.wardrobeItems.length, // Display all for now
              itemBuilder: (context, index) {
                final item = controller.wardrobeItems[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to individual item view
                    Get.toNamed('/itemDetails', arguments: item);
                  },
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.vertical(top: Radius.circular(12.0)),
                            child: Image.network(
                              item.imageUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            item.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[800],
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Currently on Wardrobe
        onTap: (index) {
          if (index == 0) {
            // Already on Wardrobe
          } else if (index == 1) {
            Get.toNamed('/outfits'); // Navigate to Outfits screen
          }
        },
        selectedItemColor: accentColor,
        unselectedItemColor: Colors.grey[600],
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
        unselectedLabelStyle: const TextStyle(fontFamily: 'Roboto'),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.checkroom), // Hanger icon
            label: 'Wardrobe',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_fix_high), // Magic wand icon
            label: 'Outfits',
          ),
        ],
      ),
    );
  }
}