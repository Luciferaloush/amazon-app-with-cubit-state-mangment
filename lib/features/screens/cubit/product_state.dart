part of 'product_cubit.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {}

class ProductError extends ProductState {}

class CategoryLoading extends ProductState {}

class CategoryLoaded extends ProductState {}

class CategoryError extends ProductState {}

class DealOfDayLoading extends ProductState {}

class DealOfDayLoad extends ProductState {

}
class DealOfDayEmpty extends ProductState  {}
class DealOfDayError extends ProductState {}
