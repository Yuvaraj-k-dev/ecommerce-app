import 'package:flutter/material.dart';

import 'package:ecommerce/ui/app_pill_button.dart';
import 'package:ecommerce/ui/screen_padding.dart';
import 'package:iconsax/iconsax.dart';

class Cartscreen extends StatelessWidget {
  const Cartscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: ScreenPadding(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Iconsax.shopping_cart, size: 54, color: Colors.black26),
              const SizedBox(height: 12),
              Text(
                'Your cart is empty',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              Text(
                'Add items to your cart to see them here.',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              AppPillButton.filled(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Iconsax.shopping_bag, size: 18),
                label: const Text('Start shopping'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
