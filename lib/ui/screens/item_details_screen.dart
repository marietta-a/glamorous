import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glamourous/controllers/item_details_controller.dart';
import 'package:glamourous/models/wardrobe_item.dart';
import 'package:glamourous/models/category.dart';
import 'package:glamourous/utils/color_utils.dart'; // Ensure mockCategories is accessible

class ItemDetailsScreen extends StatefulWidget {
  final WardrobeItem item;
  const ItemDetailsScreen({super.key, required this.item});

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  // Use Get.put to create the controller instance
  final ItemDetailsController controller = Get.put(ItemDetailsController());
  final Color accentColor = const Color(0xFF26A69A);

  @override
  void initState() {
    super.initState();
    // Initialize the controller with the item data
    controller.initItem(widget.item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Blurred Background using item image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.item.imageUrl ?? ""),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(color: Colors.black.withOpacity(0.4)),
            ),
          ),

          // 2. The Main Form Card
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(Icons.close, color: accentColor),
                        onPressed: () => Get.back(),
                      ),
                    ),
                    const Text(
                      "Confirm Item Details",
                      style: TextStyle(
                        fontSize: 18, 
                        fontWeight: FontWeight.w600, 
                        color: Colors.black54
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Item Image Preview
                    Hero(
                      tag: widget.item.id,
                      child: Container(
                        height: 180,
                        width: 180,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                          image: DecorationImage(
                            image: NetworkImage(widget.item.imageUrl ?? ""),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Form Fields
                    _buildFormRow("Item Name", _buildTextField(controller.nameController, Icons.person_outline)),
                    _buildFormRow("Category", _buildDropdown()),
                    _buildFormRow("Sub-Category", _buildTextField(controller.subCategoryController, Icons.adjust)),
                    _buildFormRow("Color", _buildColorPicker()),

                    // Multi-select Chips (Occasions)
                    _buildFormRow("Occasions", Obx(() => Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: ['Casual', 'Errands', 'Lounge', 'Work', 'Party'].map((tag) {
                        bool isSelected = controller.selectedOccasions.contains(tag);
                        return _buildChip(tag, isSelected, () => controller.toggleOccasion(tag));
                      }).toList(),
                    ))),

                    // Single-select Chips (Formality)
                    _buildFormRow("Formality", Obx(() => Wrap(
                      spacing: 8,
                      children: ['Casual', 'Smart Casual', 'Formal'].map((tag) {
                        bool isSelected = controller.selectedFormality.value == tag;
                        return _buildChip(tag, isSelected, () => controller.setFormality(tag));
                      }).toList(),
                    ))),

                    const SizedBox(height: 30),

                    // Bottom Buttons
                    Row(
                      children: [
                        Expanded(child: _buildActionButton("Save Item", accentColor, Colors.white)),
                        const SizedBox(width: 8),
                        _buildActionButton("Delete", Colors.red.shade100, Colors.red.shade900),
                        const SizedBox(width: 8),
                        Expanded(child: _buildActionButton("Next (2/5)", accentColor, Colors.white)),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper Builders ---

  Widget _buildFormRow(String label, Widget input) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            padding: const EdgeInsets.only(top: 10),
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black87, fontSize: 13)),
          ),
          Expanded(child: input),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController ctrl, IconData icon) {
    return Container(
      height: 40,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: TextField(
        controller: ctrl,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          border: InputBorder.none,
          suffixIcon: Icon(icon, size: 16, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Obx(() => DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: controller.selectedCategory.value,
          isExpanded: true,
          style: const TextStyle(color: Colors.black87, fontSize: 14),
          items: mockCategories.where((c) => c.id != 'all').map((Category cat) {
            return DropdownMenuItem<String>(value: cat.name, child: Text(cat.name));
          }).toList(),
          onChanged: (val) => controller.selectedCategory.value = val!,
        ),
      )),
    );
  }

  Widget _buildColorPicker() {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Obx(() => Container(
            width: 18, height: 18,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              color: ColorUtils.fromString(controller.primaryColorName.value),
              shape: BoxShape.rectangle,
            ),
          )),
          const SizedBox(width: 10),
          Obx(() => Text(controller.primaryColorName.value, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }

  Widget _buildChip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? accentColor : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isSelected ? accentColor : Colors.grey.shade300),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontSize: 11,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(String label, Color color, Color textColor) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: textColor,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
      child: Text(label),
    );
  }
}