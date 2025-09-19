import 'package:ecommerce/Services/wishList_provider.dart';
import 'package:ecommerce/Widgets/product_list.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ecommerce/models/products.dart';
import 'package:ecommerce/Services/product_services.dart';

import 'package:provider/provider.dart';

class Searchscreen extends StatefulWidget {
  const Searchscreen({super.key});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  List<Products> _filteredProducts = [];
  List<Products> _allProducts = [];
  TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';
  // Set<int> _wishlist = {};

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterProducts);

    ProductServices().fetchProducts().then((products) {
      setState(() {
        _allProducts = products;
        _filteredProducts = products;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterProducts() {
    setState(() {
      List<Products> tempProducts = _allProducts;
      if (_selectedCategory != 'All') {
        tempProducts =
            tempProducts
                .where(
                  (product) =>
                      product.category.toLowerCase() ==
                      _selectedCategory.toLowerCase(),
                )
                .toList();
      }
      if (_searchController.text.isNotEmpty) {
        tempProducts =
            tempProducts
                .where(
                  (product) => product.title.toLowerCase().contains(
                    _searchController.text.toLowerCase(),
                  ),
                )
                .toList();
      }
      _filteredProducts = tempProducts;
    });
  }

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search products...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        prefixIcon: Icon(Iconsax.search_normal),
                        suffixIcon:
                            _searchController.text.isNotEmpty
                                ? IconButton(
                                  icon: Icon(Icons.clear_rounded),
                                  onPressed: () {
                                    _searchController.clear();
                                    _filterProducts();
                                  },
                                )
                                : null,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Iconsax.filter),
                    onPressed: () {
                      // Implement filter functionality
                    },
                  ),
                  IconButton(
                    icon: Icon(Iconsax.shop),
                    onPressed: () {
                      // Implement cart functionality
                    },
                  ),
                ],
              ),
            ),

            // Categories Section
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              child: Row(
                children: [
                  _buildCategoryButton('All'),
                  _buildCategoryButton('Men\'s Clothing'),
                  _buildCategoryButton('Women\'s Clothing'),
                  _buildCategoryButton('Jewelery'),
                  _buildCategoryButton('Electronics'),
                ],
              ),
            ),

            // Products List (to be implemented)
            Expanded(
              child: SingleChildScrollView(
                child: ProductList(
                  products: _filteredProducts,
                  wishlist: wishlistProvider.wishlist,
                  onWishlistToggle: wishlistProvider.toggleWishlist,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            _selectedCategory = title;
            _filterProducts();
          });
        },
        style: OutlinedButton.styleFrom(
          backgroundColor:
              _selectedCategory == title ? Colors.black : Colors.white,
          foregroundColor:
              _selectedCategory == title ? Colors.white : Colors.black,
          side: BorderSide(color: Colors.black),
        ),
        child: Text(title),
      ),
    );
  }
}
