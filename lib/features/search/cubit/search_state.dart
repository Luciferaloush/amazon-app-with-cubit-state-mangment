part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading   extends SearchState {}

class SearchDone extends SearchState {}

class SearchError extends SearchState {}