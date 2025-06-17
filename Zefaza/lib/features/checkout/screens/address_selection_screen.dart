import 'package:flutter/material.dart';
import '../models/checkout_models.dart';

class AddressSelectionScreen extends StatelessWidget {
  final List<DeliveryAddress> addresses;
  final DeliveryAddress? selectedAddress;

  const AddressSelectionScreen({
    super.key,
    required this.addresses,
    this.selectedAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Address'),
      ),
      body: ListView.builder(
        itemCount: addresses.length,
        itemBuilder: (context, index) {
          final address = addresses[index];
          return ListTile(
            title: Text(address.name),
            subtitle: Text(address.fullAddress),
            trailing: selectedAddress?.id == address.id
                ? const Icon(Icons.check_circle, color: Colors.green)
                : null,
            onTap: () {
              Navigator.pop(context, address);
            },
          );
        },
      ),
    );
  }
} 