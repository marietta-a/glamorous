class WardrobeItem {
  final String id;           // Unique identifier
  final String name;         // Item name (e.g., "Denim Jeans")
  final String categoryId;   // Link to Category
  final String? imageUrl;    // Optional image for display
  final String? description; // Optional details
  final double? price;       // Optional price if shopping features are added
  final bool isFavorite;     // For user favorites
  final String? color;        // Optional color attribute (e.g. blue, red)

  WardrobeItem({
    required this.id,
    required this.name,
    required this.categoryId,
    this.imageUrl,
    this.description,
    this.price,
    this.color,
    this.isFavorite = false,
  });

  /// Factory constructor to create WardrobeItem from JSON
  factory WardrobeItem.fromJson(Map<String, dynamic> json) {
    return WardrobeItem(
      id: json['id'] as String,
      name: json['name'] as String,
      categoryId: json['categoryId'] as String,
      imageUrl: json['imageUrl'] as String?,
      description: json['description'] as String?,
      price: (json['price'] != null) ? (json['price'] as num).toDouble() : null,
      isFavorite: json['isFavorite'] ?? false,
      color: json['color'] as String?,
    );
  }

  /// Convert WardrobeItem to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'categoryId': categoryId,
      'imageUrl': imageUrl,
      'description': description,
      'price': price,
      'isFavorite': isFavorite,
      'color': color, // store color as string
    };
  }
}

// Mock wardrobe items for Glamourous
final List<WardrobeItem> mockWardrobeItems = [
  WardrobeItem(
    id: 'item1',
    name: 'Blue Denim Jeans',
    categoryId: 'bottoms',
    imageUrl: 'https://tse4.mm.bing.net/th/id/OIP.ArLmJtfgWdr5XizAdQZO9gHaJQ?rs=1&pid=ImgDetMain&o=7&rm=3',
    description: 'Classic slim-fit denim jeans.',
    price: 49.99,
    color: 'blue',
    isFavorite: true,
  ),
  WardrobeItem(
    id: 'item2',
    name: 'Leather Jacket',
    categoryId: 'outerwear',
    imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoyYm7KSb94dfCPTSS33cyS8yGjqdmWHa7Pg&s",
    description: 'Stylish black leather jacket.',
    price: 129.99,
    color: 'black',
  ),
  WardrobeItem(
    id: 'item3',
    name: 'White Sneakers',
    categoryId: 'shoes',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSC1iHxOlpRK1TlUZ3GDzujHHnT4u36JwSOMQ&s',
    description: 'Comfortable everyday sneakers.',
    price: 79.99,
    color: 'white',
    isFavorite: false,
  ),
  WardrobeItem(
    id: 'item4',
    name: 'Red Summer Dress',
    categoryId: 'dresses',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTuzYS85g3Gl7GZRyc3FwZf8_Zr6NexQzbTgw&s',
    description: 'Lightweight dress perfect for summer outings.',
    price: 59.99,
    color: 'red',
    isFavorite: true,
  ),
  WardrobeItem(
    id: 'item5',
    name: 'Gold Necklace',
    categoryId: 'accessories',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeL1cg7zwvpsv0iHsFgCDPoodzKqKEoUTKeQ&s',
    description: 'Elegant gold-plated necklace.',
    price: 199.99,
    color: 'gold',
  ),
  WardrobeItem(
    id: 'item6',
    name: 'Gray Hoodie',
    categoryId: 'tops',
    imageUrl: 'https://us.sneakenergy.com/cdn/shop/files/Grey-hoodie-front_1400x.jpg?v=1745512190',
    description: 'Cozy hoodie for casual wear.',
    price: 39.99,
    color: 'gray',
  ),
];