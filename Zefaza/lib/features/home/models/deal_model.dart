class Deal {
  final String id;
  final String name;
  final String store;
  final String price;
  final String? originalPrice;
  final int? discount;
  final String? imageUrl;
  final bool isFreeDelivery;

  const Deal({
    required this.id,
    required this.name,
    required this.store,
    required this.price,
    this.originalPrice,
    this.discount,
    this.imageUrl,
    this.isFreeDelivery = true,
  });

  factory Deal.fromJson(Map<String, dynamic> json) {
    return Deal(
      id: json['id'] as String,
      name: json['name'] as String,
      store: json['store'] as String,
      price: json['price'] as String,
      originalPrice: json['originalPrice'] as String?,
      discount: json['discount'] as int?,
      imageUrl: json['imageUrl'] as String?,
      isFreeDelivery: json['isFreeDelivery'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'store': store,
      'price': price,
      'originalPrice': originalPrice,
      'discount': discount,
      'imageUrl': imageUrl,
      'isFreeDelivery': isFreeDelivery,
    };
  }

  double get savings {
    if (originalPrice == null || discount == null) return 0;
    final original = double.tryParse(originalPrice!) ?? 0;
    final current = double.tryParse(price) ?? 0;
    return original - current;
  }
} 