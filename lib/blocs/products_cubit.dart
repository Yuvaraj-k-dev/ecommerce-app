import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerce/models/products.dart';
import 'package:ecommerce/repositories/product_repository.dart';

sealed class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object?> get props => [];
}

final class ProductsInitial extends ProductsState {
  const ProductsInitial();
}

final class ProductsLoading extends ProductsState {
  const ProductsLoading();
}

final class ProductsLoaded extends ProductsState {
  final List<Products> products;

  const ProductsLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

final class ProductsFailure extends ProductsState {
  final String message;

  const ProductsFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class ProductsCubit extends Cubit<ProductsState> {
  final ProductRepository _repository;

  ProductsCubit(this._repository) : super(const ProductsInitial());

  Future<void> loadProducts({bool forceRefresh = false}) async {
    try {
      emit(const ProductsLoading());
      final products = await _repository.getProducts(
        forceRefresh: forceRefresh,
      );
      emit(ProductsLoaded(products));
    } catch (e) {
      emit(ProductsFailure(e.toString()));
    }
  }
}
