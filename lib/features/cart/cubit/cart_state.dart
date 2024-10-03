part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<Product> listProducts;
final double total;
  CartLoaded({required this.listProducts,required this.total});
}
class CartDone extends CartState {}
class CartEmpty extends CartState {}

class CartError extends CartState {}

class RemoveCartSuccess extends CartState {}

class RemoveCartError extends CartState {}
