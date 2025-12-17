import 'package:ecommerce/Services/product_details.dart';
import 'package:ecommerce/models/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import 'package:ecommerce/blocs/wishlist_cubit.dart';
import 'package:ecommerce/ui/product_image.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductList extends StatefulWidget {
  final List<Products> products;

  const ProductList({super.key, required this.products});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  bool _didPrecache = false;

  @override
  Widget build(BuildContext context) {
    if (!_didPrecache && widget.products.isNotEmpty) {
      _didPrecache = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        for (final p in widget.products.take(24)) {
          precacheImage(CachedNetworkImageProvider(p.image), context);
        }
      });
    }

    return BlocBuilder<WishlistCubit, WishlistState>(
      builder: (context, wishlistState) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          cacheExtent: 1600,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 2 / 3,
          ),
          itemCount: widget.products.length,
          itemBuilder: (context, index) {
            final product = widget.products[index];
            final isWishlisted = wishlistState.contains(product.id);

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetails(product: product),
                  ),
                );
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
                            child: ProductImage(
                              url: product.image,
                              fit: BoxFit.contain,
                              width: double.infinity,
                              memCacheWidth: 400,
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: () {
                                context.read<WishlistCubit>().toggle(
                                  product.id,
                                );
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  isWishlisted ? Iconsax.heart5 : Iconsax.heart,
                                  color:
                                      isWishlisted ? Colors.red : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        product.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '\$ ${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
