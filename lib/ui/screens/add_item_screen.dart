import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glamourous/controllers/add_item_controller.dart';
import 'package:image_picker/image_picker.dart';

class AddItemScreen extends StatelessWidget {
  AddItemScreen({super.key});

  final AddItemController controller = Get.put(AddItemController());
  final Color accentColor = const Color(0xFF26A69A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: accentColor),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Add Item',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Obx(() => 
        controller.imagePath.value.isNotEmpty
          ? Center(
              child: Image.file(
                File(controller.imagePath.value),
                fit: BoxFit.contain,
              ),
            )
          : Column(
          children: [
            // Camera Preview Area
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Placeholder for Camera Preview
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGy1xfRRBd95Q0ezXs7z74UV-piEbtKrzCXw&s'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Dark overlay to focus on the center
                  Container(color: Colors.black.withOpacity(0.2)),
                  
                  // The Dashed Viewfinder
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomPaint(
                        size: const Size(250, 350),
                        painter: DashedRectPainter(color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Center your item here for\nbest results',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          shadows: [Shadow(blurRadius: 10, color: Colors.black)],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Bottom Controls
            Container(
              height: 150,
              color: const Color(0xFFEFEFEF),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Gallery Button
                  TextButton(
                    onPressed: () => controller.pickImage(ImageSource.gallery),
                    child: const Text(
                      'Gallery',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  // Large Camera Shutter Button
                  GestureDetector(
                    onTap: () => controller.pickImage(ImageSource.camera),
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: accentColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: accentColor.withOpacity(0.4),
                            blurRadius: 15,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: const Icon(Icons.camera_alt, color: Colors.white, size: 40),
                    ),
                  ),
                  // Empty space for layout balance (as seen in image)
                  const SizedBox(width: 60), 
                ],
              ),
            ),
          ],
        )
      )
    );
  }
}

// Custom Painter to draw the Dashed Rectangle
class DashedRectPainter extends CustomPainter {
  final Color color;
  DashedRectPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 10, dashSpace = 5, startX = 0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Drawing top line
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
    // Drawing bottom line
    startX = 0;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, size.height), Offset(startX + dashWidth, size.height), paint);
      startX += dashWidth + dashSpace;
    }
    // Drawing left line
    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashWidth), paint);
      startY += dashWidth + dashSpace;
    }
    // Drawing right line
    startY = 0;
    while (startY < size.height) {
      canvas.drawLine(Offset(size.width, startY), Offset(size.width, startY + dashWidth), paint);
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}