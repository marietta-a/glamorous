import 'package:flutter/material.dart';

class Category {
  final String id;       // Unique identifier
  final String name;     // Display name
  final IconData? icon;  // Optional icon

  Category({
    required this.id,
    required this.name,
    this.icon,
  });

  // Factory constructor to create Category from JSON
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: json['iconCodePoint'] != null
          ? IconData(
              json['iconCodePoint'] as int,
              fontFamily: json['iconFontFamily'] as String?,
              fontPackage: json['iconFontPackage'] as String?,
              matchTextDirection: json['matchTextDirection'] ?? false,
            )
          : null,
    );
  }

  // Convert Category to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      if (icon != null) ...{
        'iconCodePoint': icon!.codePoint,
        'iconFontFamily': icon!.fontFamily,
        'iconFontPackage': icon!.fontPackage,
        'matchTextDirection': icon!.matchTextDirection,
      },
    };
  }
}

// Mock categories for Glamourous
final List<Category> mockCategories = [
  Category(
    id: 'all',
    name: 'All Items',
    icon: Icons.checkroom,
  ),
  Category(
    id: 'tops',
    name: 'Tops',
    icon: Icons.checkroom,
  ),
  Category(
    id: 'bottoms',
    name: 'Bottoms',
    icon: Icons.checkroom,
  ),
  Category(
    id: 'outerwear',
    name: 'Outerwear',
    icon: Icons.checkroom,
  ),
  Category(
    id: 'shoes',
    name: 'Shoes',
    icon: Icons.checkroom,
  ),
  Category(
    id: 'accessories',
    name: 'Accessories',
    icon: Icons.checkroom,
  ),
  Category(
    id: 'dresses',
    name: 'Dresses',
    icon: Icons.checkroom,
  ),
  Category(
    id: 'activewear',
    name: 'Activewear',
    icon: Icons.checkroom,
  ),
  Category(
    id: 'swimwear',
    name: 'Swimwear',
    icon: Icons.checkroom,
  ),
  Category(
    id: 'formalwear',
    name: 'Formalwear',
    icon: Icons.checkroom,
  ),
];