import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/models/products.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:ecommerce/Widgets/random_widget.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/blocs/products_cubit.dart';
import 'package:ecommerce/ui/screen_padding.dart';
import 'package:ecommerce/Widgets/product_grid.dart';

class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<Products> _filteredProducts = [];
  List<Products> _allProducts = [];
  TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _currentPage = 0;
  bool _didPrecache = false;

  final List<String> _categories = const [
    'All',
    "Men's Clothing",
    "Women's clothing",
    'Jewelery',
    'Electronics',
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterProducts);

    // _products.then((products) {
    //   if (products.isNotEmpty) {
    //     _setRandomProductImage(products);
    //   }
    // });
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

  // void _setRandomProductImage(List<Products> products) {
  //   if (products.isNotEmpty) {
  //     final random = Random();
  //     setState(() {
  //       _randomProductImage = products[random.nextInt(products.length)].image;
  //     });
  //   }
  // }

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
            _filteredProducts =
                _filteredProducts.isNotEmpty ? _filteredProducts : _allProducts;

            if (!_didPrecache && _allProducts.isNotEmpty) {
              _didPrecache = true;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                for (final p in _allProducts.take(10)) {
                  precacheImage(CachedNetworkImageProvider(p.image), context);
                }
              });
            }

            return ScreenPadding(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black12, width: 1),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x14000000),
                                blurRadius: 12,
                                offset: Offset(0, 6),
                              ),
                            ],
                          ),
                          child: const CircleAvatar(
                            radius: 22,
                            backgroundImage: AssetImage(
                              'assets/images/profile.jpg',
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Welcome back',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Username',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        _HeaderIconButton(
                          icon: Iconsax.notification,
                          onTap: () {},
                        ),
                        const SizedBox(width: 10),
                        _HeaderIconButton(icon: Iconsax.shop, onTap: () {}),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        children: [
                          CarouselSlider(
                            items: [
                              Card(child: RandomImage(products: _allProducts)),
                              Card(child: RandomImage(products: _allProducts)),
                              Card(child: RandomImage(products: _allProducts)),
                            ],
                            options: CarouselOptions(
                              height: 220,
                              enlargeStrategy: CenterPageEnlargeStrategy.height,
                              viewportFraction: 0.75,
                              enlargeCenterPage: true,
                              autoPlay: true,
                              enableInfiniteScroll: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _currentPage = index;
                                });
                              },
                            ),
                            carouselController: _carouselController,
                          ),
                          const SizedBox(height: 10),
                          AnimatedSmoothIndicator(
                            activeIndex: _currentPage,
                            count: 3,
                            effect: const WormEffect(
                              activeDotColor: Colors.black,
                              dotHeight: 8,
                              dotWidth: 8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8),
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

class _HeaderIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _HeaderIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black12, width: 1),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Icon(icon, size: 20, color: Colors.black87),
      ),
    );
  }
}
