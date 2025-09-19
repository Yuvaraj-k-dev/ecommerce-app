import 'package:flutter/material.dart';

class WishlistProvider with ChangeNotifier {
  final Set<int> _wishlist = {};

  Set<int> get wishlist => _wishlist;

  void toggleWishlist(int productId) {
    if (_wishlist.contains(productId)) {
      _wishlist.remove(productId);
    } else {
      _wishlist.add(productId);
    }
    notifyListeners();
  }

  bool isWishlisted(int productId) {
    return _wishlist.contains(productId);
  }
}
