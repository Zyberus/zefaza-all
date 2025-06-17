class Store {
  final String id;
  final String name;
  final String category;
  final String description;
  final String address;
  final double distance;
  final double rating;
  final int reviewCount;
  final String? imageUrl;
  final List<String> tags;
  final String deliveryTime;
  final double deliveryFee;
  final bool isOpen;
  final String openHours;
  final List<Product> featuredProducts;

  Store({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.address,
    required this.distance,
    required this.rating,
    required this.reviewCount,
    this.imageUrl,
    required this.tags,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.isOpen,
    required this.openHours,
    required this.featuredProducts,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      description: json['description'],
      address: json['address'],
      distance: json['distance'].toDouble(),
      rating: json['rating'].toDouble(),
      reviewCount: json['reviewCount'],
      imageUrl: json['imageUrl'],
      tags: List<String>.from(json['tags'] ?? []),
      deliveryTime: json['deliveryTime'],
      deliveryFee: json['deliveryFee'].toDouble(),
      isOpen: json['isOpen'],
      openHours: json['openHours'],
      featuredProducts: (json['featuredProducts'] as List?)
          ?.map((p) => Product.fromJson(p))
          .toList() ?? [],
    );
  }
}

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? originalPrice;
  final String? imageUrl;
  final List<String> images;
  final String category;
  final double rating;
  final int reviewCount;
  final bool inStock;
  final String storeId;
  final String storeName;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.originalPrice,
    this.imageUrl,
    required this.images,
    required this.category,
    required this.rating,
    required this.reviewCount,
    required this.inStock,
    required this.storeId,
    required this.storeName,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      originalPrice: json['originalPrice']?.toDouble(),
      imageUrl: json['imageUrl'],
      images: List<String>.from(json['images'] ?? []),
      category: json['category'],
      rating: json['rating'].toDouble(),
      reviewCount: json['reviewCount'],
      inStock: json['inStock'],
      storeId: json['storeId'],
      storeName: json['storeName'],
    );
  }

  bool get hasDiscount => originalPrice != null && originalPrice! > price;
  
  double get discountPercentage {
    if (!hasDiscount) return 0;
    return ((originalPrice! - price) / originalPrice!) * 100;
  }
} 