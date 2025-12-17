import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ecommerce/models/products.dart';

import 'package:ecommerce/blocs/products_cubit.dart';
import 'package:ecommerce/ui/screen_padding.dart';
import 'package:ecommerce/Widgets/product_grid.dart';

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

  final List<String> _categories = const [
    'All',
    "Men's Clothing",
    "Women's Clothing",
    'Jewelery',
    'Electronics',
  ];
  // Set<int> _wishlist = {};

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterProducts);
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
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            if (state is ProductsLoading || state is ProductsInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ProductsFailure) {
              return Center(child: Text('Error: ${state.message}'));
            }
            if (state is! ProductsLoaded) {
              return const SizedBox.shrink();
            }

            _allProducts = state.products;
            if (_filteredProducts.isEmpty) {
              _filteredProducts = _allProducts;
            }

            return ScreenPadding(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search products...',
                              prefixIcon: const Icon(Iconsax.search_normal),
                              suffixIcon:
                                  _searchController.text.isNotEmpty
                                      ? IconButton(
                                        icon: const Icon(Icons.clear_rounded),
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
                          icon: const Icon(Iconsax.filter),
                          onPressed: () {
                            // Implement filter functionality
                          },
                        ),
                        IconButton(
                          icon: const Icon(Iconsax.shop),
                          onPressed: () {
                            // Implement cart functionality
                          },
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children:
                              _categories.map((c) {
                                final selected = _selectedCategory == c;
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: ChoiceChip(
                                    label: Text(c),
                                    selected: selected,
                                    selectedColor: Colors.black,
                                    backgroundColor: Colors.white,
                                    side: const BorderSide(
                                      color: Colors.black12,
                                    ),
                                    labelStyle: TextStyle(
                                      color:
                                          selected
                                              ? Colors.white
                                              : Colors.black87,
                                      fontWeight:
                                          selected
                                              ? FontWeight.w600
                                              : FontWeight.w500,
                                    ),
                                    onSelected: (_) {
                                      setState(() {
                                        _selectedCategory = c;
                                        _filterProducts();
                                      });
                                    },
                                  ),
                                );
                              }).toList(),
                        ),
                      ),
                    ),
                  ),
                  ProductGridSliver(products: _filteredProducts),
                  const SliverToBoxAdapter(child: SizedBox(height: 8)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
