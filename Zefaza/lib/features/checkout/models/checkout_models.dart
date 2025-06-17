class CheckoutItem {
  final String id;
  final String name;
  final String image;
  final double price;
  final int quantity;
  final String seller;
  final bool isPrime;
  final String deliveryDate;

  CheckoutItem({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
    required this.seller,
    required this.isPrime,
    required this.deliveryDate,
  });
}

class DeliveryAddress {
  final String id;
  final String name;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String state;
  final String zipCode;
  final String country;
  final bool isDefault;

  DeliveryAddress({
    required this.id,
    required this.name,
    required this.addressLine1,
    this.addressLine2 = '',
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
    required this.isDefault,
  });

  String get fullAddress {
    final address2 = addressLine2.isNotEmpty ? ', $addressLine2' : '';
    return '$addressLine1$address2, $city, $state $zipCode';
  }
}

class PaymentMethod {
  final String id;
  final String type; // 'card', 'paypal', 'apple_pay', 'gift_card'
  final String displayName;
  final String? last4; // For cards
  final String? expiryDate; // For cards
  final String? cardType; // visa, mastercard, etc.
  final bool isDefault;

  PaymentMethod({
    required this.id,
    required this.type,
    required this.displayName,
    this.last4,
    this.expiryDate,
    this.cardType,
    required this.isDefault,
  });
}

class CheckoutSummary {
  final double subtotal;
  final double shipping;
  final double tax;
  final double discount;
  final double total;
  final int totalItems;
  final String estimatedDelivery;

  CheckoutSummary({
    required this.subtotal,
    required this.shipping,
    required this.tax,
    required this.discount,
    required this.total,
    required this.totalItems,
    required this.estimatedDelivery,
  });
}

class DeliveryOption {
  final String id;
  final String name;
  final String description;
  final double cost;
  final String estimatedDate;
  final bool isFree;
  final bool isPrime;

  DeliveryOption({
    required this.id,
    required this.name,
    required this.description,
    required this.cost,
    required this.estimatedDate,
    required this.isFree,
    required this.isPrime,
  });
} 