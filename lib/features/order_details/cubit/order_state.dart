part of 'order_cubit.dart';

@immutable
abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderDone   extends OrderState {}

class OrderEmpty extends OrderState {}

class OrderError extends OrderState {}
