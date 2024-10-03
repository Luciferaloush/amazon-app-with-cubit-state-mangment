part of 'product_details_cubit.dart';

@immutable
abstract class ProductDetailsState {}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoad extends ProductDetailsState {
  final List<Product> listProducts;

  ProductDetailsLoad({required this.listProducts});
}

class ProductDetailsEmpty extends ProductDetailsState {}

class ProductDetailsError extends ProductDetailsState {}

class AddRatingDone extends ProductDetailsState {}

class AddRatingError extends ProductDetailsState {}

class AddProductSuccess extends ProductDetailsState {}

class AddProductError extends ProductDetailsState {}