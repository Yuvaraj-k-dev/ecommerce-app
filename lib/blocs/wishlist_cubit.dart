import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class WishlistState extends Equatable {
  final Set<int> ids;

  const WishlistState({required this.ids});

  factory WishlistState.initial() => const WishlistState(ids: <int>{});

  bool contains(int productId) => ids.contains(productId);

  @override
  List<Object?> get props => [ids];
}

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(WishlistState.initial());

  void toggle(int productId) {
    final next = Set<int>.from(state.ids);
    if (next.contains(productId)) {
      next.remove(productId);
    } else {
      next.add(productId);
    }
    emit(WishlistState(ids: next));
  }
}
