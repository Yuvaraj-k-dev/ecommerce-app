import 'package:ecommerce/Services/product_details.dart';
import 'package:ecommerce/blocs/wishlist_cubit.dart';
import 'package:ecommerce/models/products.dart';
import 'package:ecommerce/ui/product_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class ProductGridSliver extends StatefulWidget {
  final List<Products> products;

  const ProductGridSliver({super.key, required this.products});

  @override
  State<ProductGridSliver> createState() => _ProductGridSliverState();
}

class _ProductGridSliverState extends State<ProductGridSliver> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistCubit, WishlistState>(
      builder: (context, wishlistState) {
        return SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2 / 3,
          ),
          delegate: SliverChildBuilderDelegate((context, index) {
            final product = widget.products[index];
            final isWishlisted = wishlistState.contains(product.id);

            return _ProductTile(product: product, isWishlisted: isWishlisted);
          }, childCount: widget.products.length),
        );
      },
    );
  }
}

class _ProductTile extends StatelessWidget {
  final Products product;
  final bool isWishlisted;

  const _ProductTile({required this.product, required this.isWishlisted});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetails(product: product),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    color: const Color(0xFFF6F6F6),
                    child: Center(
                      child: ProductImage(
                        url: product.image,
                        fit: BoxFit.contain,
                        width: double.infinity,
                        memCacheWidth: 450,
                        memCacheHeight: 450,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(999),
                      onTap: () {
                        context.read<WishlistCubit>().toggle(product.id);
                      },
                      child: Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Icon(
                          isWishlisted ? Iconsax.heart5 : Iconsax.heart,
                          color: isWishlisted ? Colors.red : Colors.black54,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 4),
              child: Text(
                product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Colors.green[700],
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
