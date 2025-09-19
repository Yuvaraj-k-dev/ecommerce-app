import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/Services/product_services.dart';
import 'package:ecommerce/Widgets/product_list.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/models/products.dart';
import 'package:iconsax/iconsax.dart';

import 'package:provider/provider.dart';
import 'package:ecommerce/Services/wishList_provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:ecommerce/Widgets/random_widget.dart';

class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  late Future<List<Products>> _products;
  List<Products> _filteredProducts = [];
  List<Products> _allProducts = [];
  TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _products = ProductServices().fetchProducts();
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
    final wishlistProvider = Provider.of<WishlistProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<List<Products>>(
          future: _products,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            _allProducts = snapshot.data ?? [];
            _filteredProducts =
                _filteredProducts.isNotEmpty ? _filteredProducts : _allProducts;

            // if (_randomProductImage == null && _allProducts.isNotEmpty) {
            //   _setRandomProductImage(_allProducts);
            // }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(
                              'assets/images/profile.jpg',
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Username',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 50),
                      Icon(Iconsax.notification, size: 25),
                      Icon(Iconsax.shop, size: 25),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    children: [
                      CarouselSlider(
                        items: [
                          Card(
                            elevation: 4,
                            child: RandomImage(products: _allProducts),
                          ),
                          Card(
                            elevation: 4,
                            child: RandomImage(products: _allProducts),
                          ),
                          Card(
                            elevation: 4,
                            child: RandomImage(products: _allProducts),
                          ),
                        ],
                        options: CarouselOptions(
                          height: 220,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          viewportFraction: 0.75,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          enableInfiniteScroll: true,
                          autoPlayInterval: Duration(seconds: 3),
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

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildCategoryButton('All'),
                      _buildCategoryButton('Men\'s Clothing'),
                      _buildCategoryButton('Women\'s clothing'),
                      _buildCategoryButton('Jewelery'),
                      _buildCategoryButton('Electronics'),
                    ],
                  ),
                ),

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
            );
          },
        ),
      ),
    );
  }

  Widget _buildCategoryButton(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            _selectedCategory = title;
            _filterProducts();
          });
        },
        child: Text(title, style: TextStyle(color: Colors.black)),
      ),
    );
  }
}
