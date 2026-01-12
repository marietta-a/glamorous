import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glamourous/controllers/outfit_controller.dart';
import 'package:glamourous/models/wardrobe_item.dart';

class OutfitScreen extends StatelessWidget {
  OutfitScreen({super.key});

  final OutfitController controller = Get.put(OutfitController());
  final Color accentColor = const Color(0xFF26A69A); // Teal color from image

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: accentColor, size: 20),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Outfits',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: accentColor),
            onPressed: () => controller.generateRandomOutfit(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              "Today's Casual Look",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: accentColor.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 30),
            // The 2x2 Grid
            Expanded(
              child: Obx(() => GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 0.9,
                    children: [
                      _buildOutfitCard("Top", controller.top.value),
                      _buildOutfitCard("Accessory", controller.accessory.value),
                      _buildOutfitCard("Bottom", controller.bottom.value),
                      _buildOutfitCard("Shoes", controller.shoes.value),
                    ],
                  )),
            ),
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: _buildActionButton("Save Outfit", accentColor, Colors.white),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildActionButton("Edit Outfit", accentColor, Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildOutfitCard(String label, WardrobeItem? item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Stack(
        children: [
          // Label (Top Right)
          Positioned(
            top: 12,
            right: 12,
            child: Text(
              label,
              style: TextStyle(
                color: accentColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // Image
          Center(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: item?.imageUrl != null
                  ? Image.network(item!.imageUrl!, fit: BoxFit.contain)
                  : Icon(Icons.add, color: Colors.grey[300], size: 40),
            ),
          ),
          // Icon (Bottom Right)
          Positioned(
            bottom: 12,
            right: 12,
            child: Icon(
              label == "Top" || label == "Bottom" ? Icons.lock_outline : Icons.auto_awesome_outlined,
              color: accentColor,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String title, Color bgColor, Color textColor) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: textColor,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 0,
      ),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}