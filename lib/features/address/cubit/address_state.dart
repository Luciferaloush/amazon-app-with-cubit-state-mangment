part of 'address_cubit.dart';

@immutable
abstract class AddressState {}

class AddressInitial extends AddressState {}

class ProductLoading extends AddressState {}

class ProductLoaded extends AddressState {

}

class ProductEmpty extends AddressState {}

class ProductError extends AddressState {}
