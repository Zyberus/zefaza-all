import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../models/checkout_models.dart';
import 'address_selection_screen.dart';
import 'payment_selection_screen.dart';
import 'order_confirmation_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  DeliveryAddress? _selectedAddress;
  PaymentMethod? _selectedPayment;
  DeliveryOption? _selectedDelivery;
  
  final List<CheckoutItem> _items = [
    CheckoutItem(
      id: '1',
      name: 'iPhone 15 Pro Max 256GB',
      image: '📱',
      price: 1199.99,
      quantity: 1,
      seller: 'Apple',
      isPrime: true,
      deliveryDate: 'Tomorrow',
    ),
    CheckoutItem(
      id: '2',
      name: 'AirPods Pro (2nd Gen)',
      image: '🎧',
      price: 249.99,
      quantity: 1,
      seller: 'Apple',
      isPrime: true,
      deliveryDate: 'Tomorrow',
    ),
  ];

  final List<DeliveryAddress> _addresses = [
    DeliveryAddress(
      id: '1',
      name: 'John Doe',
      addressLine1: '123 Main Street',
      addressLine2: 'Apt 4B',
      city: 'New York',
      state: 'NY',
      zipCode: '10001',
      country: 'USA',
      isDefault: true,
    ),
    DeliveryAddress(
      id: '2',
      name: 'John Doe',
      addressLine1: '456 Work Avenue',
      city: 'New York',
      state: 'NY',
      zipCode: '10002',
      country: 'USA',
      isDefault: false,
    ),
  ];

  final List<PaymentMethod> _paymentMethods = [
    PaymentMethod(
      id: '1',
      type: 'card',
      displayName: 'Visa ending in 1234',
      last4: '1234',
      expiryDate: '12/26',
      cardType: 'visa',
      isDefault: true,
    ),
    PaymentMethod(
      id: '2',
      type: 'apple_pay',
      displayName: 'Apple Pay',
      isDefault: false,
    ),
  ];

  final List<DeliveryOption> _deliveryOptions = [
    DeliveryOption(
      id: '1',
      name: 'Prime FREE One-Day',
      description: 'Tomorrow before 9 PM',
      cost: 0.0,
      estimatedDate: 'Tomorrow',
      isFree: true,
      isPrime: true,
    ),
    DeliveryOption(
      id: '2',
      name: 'FREE Standard Delivery',
      description: 'Tuesday, Dec 12',
      cost: 0.0,
      estimatedDate: 'Dec 12',
      isFree: true,
      isPrime: false,
    ),
    DeliveryOption(
      id: '3',
      name: 'Priority Delivery',
      description: 'Today before 6 PM',
      cost: 9.99,
      estimatedDate: 'Today',
      isFree: false,
      isPrime: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selectedAddress = _addresses.firstWhere((addr) => addr.isDefault);
    _selectedPayment = _paymentMethods.firstWhere((payment) => payment.isDefault);
    _selectedDelivery = _deliveryOptions.first;
  }

  CheckoutSummary get _summary {
    final subtotal = _items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
    final shipping = _selectedDelivery?.cost ?? 0.0;
    final tax = subtotal * 0.0875;
    final total = subtotal + shipping + tax;
    
    return CheckoutSummary(
      subtotal: subtotal,
      shipping: shipping,
      tax: tax,
      discount: 0.0,
      total: total,
      totalItems: _items.fold(0, (sum, item) => sum + item.quantity),
      estimatedDelivery: _selectedDelivery?.estimatedDate ?? 'TBD',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProgressIndicator(),
            _buildDeliverySection(),
            _buildPaymentSection(),
            _buildItemsSection(),
            _buildDeliveryOptionsSection(),
            _buildPromotionSection(),
            _buildOrderSummarySection(),
            const SizedBox(height: 100), // Space for bottom button
          ],
        ),
      ),
      bottomNavigationBar: _buildPlaceOrderButton(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black87),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        'Checkout',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.help_outline, color: Colors.black87),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          _buildProgressStep('1', 'Address', true),
          _buildProgressLine(true),
          _buildProgressStep('2', 'Payment', true),
          _buildProgressLine(true),
          _buildProgressStep('3', 'Review', true),
          _buildProgressLine(false),
          _buildProgressStep('4', 'Complete', false),
        ],
      ),
    );
  }

  Widget _buildProgressStep(String number, String label, bool completed) {
    return Column(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: completed ? AppTheme.primaryBlack : Colors.grey[300],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: completed
                ? const Icon(Icons.check, color: Colors.white, size: 16)
                : Text(
                    number,
                    style: TextStyle(
                      color: completed ? Colors.white : Colors.grey[600],
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: completed ? AppTheme.primaryBlack : Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressLine(bool completed) {
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(bottom: 20),
        color: completed ? AppTheme.primaryBlack : Colors.grey[300],
      ),
    );
  }

  Widget _buildDeliverySection() {
    return _buildSection(
      title: '1. Delivery address',
      child: InkWell(
        onTap: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddressSelectionScreen(
                addresses: _addresses,
                selectedAddress: _selectedAddress,
              ),
            ),
          );
          if (result != null) {
            setState(() {
              _selectedAddress = result;
            });
          }
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Icons.location_on, color: Colors.orange, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _selectedAddress?.name ?? 'Select address',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    if (_selectedAddress != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        _selectedAddress!.fullAddress,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentSection() {
    return _buildSection(
      title: '2. Payment method',
      child: InkWell(
        onTap: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentSelectionScreen(
                paymentMethods: _paymentMethods,
                selectedPayment: _selectedPayment,
              ),
            ),
          );
          if (result != null) {
            setState(() {
              _selectedPayment = result;
            });
          }
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                _getPaymentIcon(_selectedPayment?.type),
                color: Colors.blue,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  _selectedPayment?.displayName ?? 'Select payment method',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemsSection() {
    return _buildSection(
      title: '3. Review items (${_summary.totalItems})',
      child: Column(
        children: _items.map((item) => _buildItemCard(item)).toList(),
      ),
    );
  }

  Widget _buildItemCard(CheckoutItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                item.image,
                style: const TextStyle(fontSize: 32),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'Sold by ${item.seller}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue[700],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    if (item.isPrime) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.blue[600],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'prime',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    Icon(
                      Icons.local_shipping,
                      size: 14,
                      color: Colors.green[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'FREE delivery ${item.deliveryDate}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.green[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Qty: ${item.quantity}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '\$${(item.price * item.quantity).toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryOptionsSection() {
    return _buildSection(
      title: '4. Choose delivery option',
      child: Column(
        children: _deliveryOptions.map((option) => _buildDeliveryOption(option)).toList(),
      ),
    );
  }

  Widget _buildDeliveryOption(DeliveryOption option) {
    final isSelected = _selectedDelivery?.id == option.id;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: RadioListTile<String>(
        value: option.id,
        groupValue: _selectedDelivery?.id,
        onChanged: (value) {
          setState(() {
            _selectedDelivery = option;
          });
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        title: Row(
          children: [
            Text(
              option.name,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: isSelected ? AppTheme.primaryBlack : Colors.black87,
              ),
            ),
            if (option.isPrime) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                decoration: BoxDecoration(
                  color: Colors.blue[600],
                  borderRadius: BorderRadius.circular(2),
                ),
                child: const Text(
                  'prime',
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
            const Spacer(),
            Text(
              option.isFree ? 'FREE' : '\$${option.cost.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: option.isFree ? Colors.green[600] : Colors.black87,
              ),
            ),
          ],
        ),
        subtitle: Text(
          option.description,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        activeColor: AppTheme.primaryBlack,
      ),
    );
  }

  Widget _buildPromotionSection() {
    return _buildSection(
      title: '5. Promotions',
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.orange[50],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.orange[200]!),
        ),
        child: Row(
          children: [
            Icon(Icons.local_offer, color: Colors.orange[600], size: 20),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Enter gift card or promotional code',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Apply',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummarySection() {
    final summary = _summary;
    return _buildSection(
      title: 'Order Summary',
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Column(
          children: [
            _buildSummaryRow('Items (${summary.totalItems}):', '\$${summary.subtotal.toStringAsFixed(2)}'),
            _buildSummaryRow('Shipping & handling:', summary.shipping == 0 ? 'FREE' : '\$${summary.shipping.toStringAsFixed(2)}'),
            _buildSummaryRow('Estimated tax:', '\$${summary.tax.toStringAsFixed(2)}'),
            const Divider(height: 24),
            _buildSummaryRow(
              'Order total:',
              '\$${summary.total.toStringAsFixed(2)}',
              isTotal: true,
            ),
            const SizedBox(height: 12),
            Text(
              'Estimated delivery: ${summary.estimatedDelivery}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.green[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w600,
              color: isTotal ? Colors.red[600] : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildPlaceOrderButton() {
    final summary = _summary;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Order Total:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '\$${summary.total.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.red[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _canPlaceOrder ? _placeOrder : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[400],
                  foregroundColor: Colors.black87,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Place your order',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'By placing your order, you agree to our terms and conditions.',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  bool get _canPlaceOrder {
    return _selectedAddress != null && _selectedPayment != null && _selectedDelivery != null;
  }

  IconData _getPaymentIcon(String? type) {
    switch (type) {
      case 'card':
        return Icons.credit_card;
      case 'apple_pay':
        return Icons.apple;
      case 'paypal':
        return Icons.payment;
      default:
        return Icons.payment;
    }
  }

  void _placeOrder() {
    // Show loading and then navigate to confirmation
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Simulate order processing
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pop(); // Remove loading dialog
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OrderConfirmationScreen(
            orderNumber: 'ZF-${DateTime.now().millisecondsSinceEpoch}',
            summary: _summary,
            deliveryAddress: _selectedAddress!,
            items: _items,
          ),
        ),
      );
    });
  }
} 