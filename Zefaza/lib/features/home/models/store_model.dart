class Store {
  final String id;
  final String name;
  final String category;
  final String distance;
  final double rating;
  final String? imageUrl;
  final bool isOpen;
  final String? deliveryTime;

  const Store({
    required this.id,
    required this.name,
    required this.category,
    required this.distance,
    required this.rating,
    this.imageUrl,
    this.isOpen = true,
    this.deliveryTime,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      distance: json['distance'] as String,
      rating: (json['rating'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String?,
      isOpen: json['isOpen'] as bool? ?? true,
      deliveryTime: json['deliveryTime'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'distance': distance,
      'rating': rating,
      'imageUrl': imageUrl,
      'isOpen': isOpen,
      'deliveryTime': deliveryTime,
    };
  }
} 