part of 'add_product_cubit.dart';

@immutable
abstract class AddProductState {}

class AddProductInitial extends AddProductState {}

class NewValue extends AddProductState {
  final String category;

  NewValue({required this.category});
}

class PickImages extends AddProductState {
  final List<File>images;
  PickImages({required this.images});
}

class ProductLoading extends AddProductState {}

class ProductLoaded extends AddProductState {
  final List<Product> listProducts;

  ProductLoaded({required this.listProducts});
}

class ProductEmpty extends AddProductState {}

class AddProductDone extends AddProductState {}

class AddProductLoading extends AddProductState {}

class ProductError extends AddProductState {}

class DeleteProductDone extends AddProductState {}

class DeleteProductError extends AddProductState {}

class OrdersLoading extends AddProductState {}

class OrderDone extends AddProductState {}

class OrderEmpty extends AddProductState {}

class OrderError extends AddProductState {}

class ChangeOrderStatusSuccess extends AddProductState {}

class ChangeOrderStatusFailure extends AddProductState {}

class EarningsLoading   extends AddProductState {}

class EarningsLoaded extends AddProductState {}

class EarningsFailed extends AddProductState {}