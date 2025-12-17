import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import 'package:ecommerce/blocs/products_cubit.dart';
import 'package:ecommerce/blocs/wishlist_cubit.dart';
import 'package:ecommerce/ui/app_pill_button.dart';
import 'package:ecommerce/ui/screen_padding.dart';
import 'package:ecommerce/Widgets/product_grid.dart';

class WishlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Wishlist"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Iconsax.shop),
              onPressed: () {
                // Navigate to cart screen
              },
            ),
          ],
        ),
        body: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, productsState) {
            if (productsState is ProductsLoading ||
                productsState is ProductsInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (productsState is ProductsFailure) {
              return const Center(child: Text('Error loading wishlist'));
            }
            if (productsState is! ProductsLoaded) {
              return const SizedBox.shrink();
            }

            return BlocBuilder<WishlistCubit, WishlistState>(
              builder: (context, wishlistState) {
                final allProducts = productsState.products;
                final wishlistItems =
                    allProducts
                        .where((product) => wishlistState.contains(product.id))
                        .toList();

                if (wishlistItems.isEmpty) {
                  return ScreenPadding(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Iconsax.heart, size: 54, color: Colors.black26),
                          const SizedBox(height: 12),
                          Text(
                            'Your wishlist is empty',
                            style: Theme.of(context).textTheme.titleLarge,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Save items you love to find them quickly later.',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Colors.black54),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          AppPillButton.filled(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Iconsax.shop, size: 18),
                            label: const Text('Browse products'),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return ScreenPadding(
                  child: CustomScrollView(
                    slivers: [
                      ProductGridSliver(products: wishlistItems),
                      const SliverToBoxAdapter(child: SizedBox(height: 8)),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
