import 'package:flutter/material.dart';
import 'dart:math';
import 'package:ecommerce/models/products.dart';

class RandomImage extends StatefulWidget {
  final List<Products> products;

  const RandomImage({super.key, required this.products});

  @override
  State<RandomImage> createState() => _RandomImageState();
}

class _RandomImageState extends State<RandomImage> {
  late String? _randomProductImage;

  @override
  void initState() {
    super.initState();
    _setRandomProductImage();
  }

  void _setRandomProductImage() {
    if (widget.products.isNotEmpty) {
      final random = Random();
      _randomProductImage =
          widget.products[random.nextInt(widget.products.length)].image;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child:
                _randomProductImage != null
                    ? Image.network(
                      _randomProductImage!,
                      height: 200,
                      width: 350,
                      fit: BoxFit.contain,
                    )
                    : Container(
                      height: 200,
                      width: double.infinity,
                      color: Colors.grey[200],
                      child: const Center(child: CircularProgressIndicator()),
                    ),
          ),
          Positioned(
            left: 1,
            bottom: 8,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: const Text('Buy Now', style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}
