import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/Services/wishList_provider.dart';
import 'package:ecommerce/models/products.dart';
import 'package:ecommerce/Services/product_services.dart';
import 'package:ecommerce/Widgets/product_list.dart';

class WishlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);

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
        body: FutureBuilder<List<Products>>(
          future: ProductServices().fetchProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error loading wishlist'));
            }

            final allProducts = snapshot.data ?? [];
            final wishlistItems =
                allProducts
                    .where(
                      (product) =>
                          wishlistProvider.wishlist.contains(product.id),
                    )
                    .toList();

            if (wishlistItems.isEmpty) {
              return Center(child: Text("Your wishlist is empty."));
            }

            return SingleChildScrollView(
              child: ProductList(
                products: wishlistItems,
                wishlist: wishlistProvider.wishlist,
                onWishlistToggle: wishlistProvider.toggleWishlist,
              ),
            );
          },
        ),
      ),
    );
  }
}
