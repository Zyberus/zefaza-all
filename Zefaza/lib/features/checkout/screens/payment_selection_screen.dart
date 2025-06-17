import 'package:flutter/material.dart';
import '../models/checkout_models.dart';

class PaymentSelectionScreen extends StatelessWidget {
  final List<PaymentMethod> paymentMethods;
  final PaymentMethod? selectedPayment;

  const PaymentSelectionScreen({
    super.key,
    required this.paymentMethods,
    this.selectedPayment,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Payment'),
      ),
      body: ListView.builder(
        itemCount: paymentMethods.length,
        itemBuilder: (context, index) {
          final payment = paymentMethods[index];
          return ListTile(
            title: Text(payment.displayName),
            leading: Icon(_getPaymentIcon(payment.type)),
            trailing: selectedPayment?.id == payment.id
                ? const Icon(Icons.check_circle, color: Colors.green)
                : null,
            onTap: () {
              Navigator.pop(context, payment);
            },
          );
        },
      ),
    );
  }

  IconData _getPaymentIcon(String type) {
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
} 