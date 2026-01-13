class WardrobeItem {
  final String id;                  // Unique identifier
  final String userId;                  // Unique identifier
  final String name;                // Item name (e.g., "Denim Jeans")
  final String category;            // Category (e.g., "Outerwear")
  final String? subCategory;        // Sub-category (e.g., "Denim Jacket")
  final String? primaryColor;       // Primary color (e.g., "Blue")
  final List<String>? secondaryColors; // Secondary colors
  final String? pattern;            // Pattern (e.g., "Solid")
  final String? materialLook;       // Material look (e.g., "Denim")
  final List<String>? seasonality;  // Seasons (e.g., ["Spring", "Autumn"])
  final String? formality;          // Formality (e.g., "Casual")
  final String? warmthLevel;        // Warmth level (e.g., "Medium")
  final List<String>? fitsWithColors; // Colors it pairs well with
  final List<String>? occasionSuitability; // Suitable occasions
  final List<String>? tags;         // Tags (e.g., ["vintage", "distressed"])
  final String? imageUrl;           // Optional image for display
  final String? description;        // Optional details
  final double? price;              // Optional price if shopping features are added
  final bool isFavorite;            // For user favorites

  WardrobeItem({
    required this.id,
    required this.name,
    required this.category,
    required this.userId,
    this.subCategory,
    this.primaryColor,
    this.secondaryColors,
    this.pattern,
    this.materialLook,
    this.seasonality,
    this.formality,
    this.warmthLevel,
    this.fitsWithColors,
    this.occasionSuitability,
    this.tags,
    this.imageUrl,
    this.description,
    this.price,
    this.isFavorite = false,
  });

  /// Factory constructor to create WardrobeItem from JSON
  factory WardrobeItem.fromJson(Map<String, dynamic> json) {
    return WardrobeItem(
      id: json['item_id'] as String,
      userId: json['user_id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      subCategory: json['sub_category'] as String?,
      primaryColor: json['primary_color'] as String?,
      secondaryColors: (json['secondary_colors'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      pattern: json['pattern'] as String?,
      materialLook: json['material_look'] as String?,
      seasonality: (json['seasonality'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      formality: json['formality'] as String?,
      warmthLevel: json['warmth_level'] as String?,
      fitsWithColors: (json['fits_with_colors'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      occasionSuitability: (json['occasion_suitability'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      imageUrl: json['image_url'] as String?,
      description: json['description'] as String?,
      price: (json['price'] != null) ? (json['price'] as num).toDouble() : null,
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  /// Convert WardrobeItem to JSON
  Map<String, dynamic> toJson() {
    return {
      'item_id': id,
      'user_id': userId,
      'name': name,
      'category': category,
      'sub_category': subCategory,
      'primary_color': primaryColor,
      'secondary_colors': secondaryColors,
      'pattern': pattern,
      'material_look': materialLook,
      'seasonality': seasonality,
      'formality': formality,
      'warmth_level': warmthLevel,
      'fits_with_colors': fitsWithColors,
      'occasion_suitability': occasionSuitability,
      'tags': tags,
      'image_url': imageUrl,
      'description': description,
      'price': price,
      'isFavorite': isFavorite,
    };
  }
}

// Mock wardrobe items for Glamourous
final List<WardrobeItem> mockWardrobeItems = [
  WardrobeItem(
    id: 'item1',
    userId: "user123",
    name: 'Blue Denim Jeans',
    category: 'Bottoms',
    subCategory: 'Jeans',
    primaryColor: 'Blue',
    secondaryColors: ['Indigo'],
    pattern: 'Solid',
    materialLook: 'Denim',
    seasonality: ['Spring', 'Autumn', 'Winter'],
    formality: 'Casual',
    warmthLevel: 'Medium',
    fitsWithColors: ['White', 'Black', 'Grey'],
    occasionSuitability: ['School', 'Casual Outing'],
    tags: ['denim', 'slim-fit', 'classic'],
    imageUrl: 'https://tse4.mm.bing.net/th/id/OIP.ArLmJtfgWdr5XizAdQZO9gHaJQ?rs=1&pid=ImgDetMain&o=7&rm=3',
    description: 'Classic slim-fit denim jeans.',
    price: 49.99,
    isFavorite: true,
  ),
  WardrobeItem(
    id: 'item2',
    userId: "user123",
    name: 'Leather Jacket',
    category: 'Outerwear',
    subCategory: 'Jacket',
    primaryColor: 'Black',
    secondaryColors: ['Silver'],
    pattern: 'Solid',
    materialLook: 'Leather',
    seasonality: ['Autumn', 'Winter'],
    formality: 'Casual',
    warmthLevel: 'High',
    fitsWithColors: ['White', 'Grey', 'Denim'],
    occasionSuitability: ['Concert', 'Casual Date'],
    tags: ['leather', 'stylish', 'biker'],
    imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoyYm7KSb94dfCPTSS33cyS8yGjqdmWHa7Pg&s",
    description: 'Stylish black leather jacket.',
    price: 129.99,
  ),
  WardrobeItem(
    id: 'item3',
    userId: "user123",
    name: 'White Sneakers',
    category: 'Shoes',
    subCategory: 'Sneakers',
    primaryColor: 'White',
    secondaryColors: ['Silver'],
    pattern: 'Solid',
    materialLook: 'Canvas',
    seasonality: ['Spring', 'Summer', 'Autumn'],
    formality: 'Casual',
    warmthLevel: 'Low',
    fitsWithColors: ['Blue', 'Black', 'Beige'],
    occasionSuitability: ['School', 'Casual Outing', 'Concert'],
    tags: ['sneakers', 'comfortable', 'sporty'],
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSC1iHxOlpRK1TlUZ3GDzujHHnT4u36JwSOMQ&s',
    description: 'Comfortable everyday sneakers.',
    price: 79.99,
    isFavorite: false,
  ),
  WardrobeItem(
    id: 'item4',
    userId: "user123",
    name: 'Red Summer Dress',
    category: 'Dresses',
    subCategory: 'Dress',
    primaryColor: 'Red',
    secondaryColors: ['White'],
    pattern: 'Floral',
    materialLook: 'Cotton',
    seasonality: ['Spring', 'Summer'],
    formality: 'Casual',
    warmthLevel: 'Low',
    fitsWithColors: ['White', 'Beige'],
    occasionSuitability: ['Casual Date', 'Picnic'],
    tags: ['summer', 'lightweight', 'flowy'],
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTuzYS85g3Gl7GZRyc3FwZf8_Zr6NexQzbTgw&s',
    description: 'Lightweight dress perfect for summer outings.',
    price: 59.99,
    isFavorite: true,
  ),
  WardrobeItem(
    id: 'item5',
    userId: "user123",
    name: 'Gold Necklace',
    category: 'Accessories',
    subCategory: 'Jewelry',
    primaryColor: 'Gold',
    secondaryColors: ['Silver'],
    pattern: 'None',
    materialLook: 'Metal',
    seasonality: ['All'],
    formality: 'Formal',
    warmthLevel: 'N/A',
    fitsWithColors: ['Black', 'White', 'Red'],
    occasionSuitability: ['Formal Event', 'Casual Date'],
    tags: ['jewelry', 'elegant', 'gold-plated'],
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSJsDINe7iLpVLlW8DycEi3j0Wm1pVB_YzPg&s',
    description: 'Elegant gold-plated necklace.',
    price: 199.99,
  ),
  WardrobeItem(
    id: 'item6',
    userId: "user123",
    name: 'Gray Hoodie',
    category: 'Tops',
    subCategory: 'Hoodie',
    primaryColor: 'Gray',
    secondaryColors: ['Black'],
    pattern: 'Solid',
    materialLook: 'Cotton Blend',
    seasonality: ['Autumn', 'Winter'],
    formality: 'Casual',
    warmthLevel: 'Medium',
    fitsWithColors: ['Blue', 'Black', 'White'],
    occasionSuitability: ['School', 'Casual Outing'],
    tags: ['hoodie', 'cozy', 'casual'],
    imageUrl: 'https://us.sneakenergy.com/cdn/shop/files/Grey-hoodie-front_1400x.jpg?v=1745512190',
    description: 'Cozy hoodie for casual wear.',
    price: 39.99,
  ),
];