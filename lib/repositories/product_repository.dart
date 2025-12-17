import 'package:ecommerce/Services/product_services.dart';
import 'package:ecommerce/models/products.dart';

class ProductRepository {
  final ProductServices _services;
  List<Products>? _cache;

  ProductRepository(this._services);

  Future<List<Products>> getProducts({bool forceRefresh = false}) async {
    if (!forceRefresh && _cache != null) {
      return _cache!;
    }
    final products = await _services.fetchProducts();
    _cache = products;
    return products;
  }
}
