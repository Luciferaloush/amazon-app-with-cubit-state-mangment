part of 'account_cubit.dart';

@immutable
abstract class AccountState {}

class AccountInitial extends AccountState {}

class OrderLoading extends AccountState {}

class OrderLoaded extends AccountState {
  final List<Order> orderList;

  OrderLoaded({required
  this.orderList});
}
class OrderEmpty extends AccountState {}
class OrderError extends AccountState {}
