
part of 'api_bloc.dart';

@immutable
abstract class ApiState {}

class ApiInitial extends ApiState {}

class CategoriesLoading extends ApiState {}

class CategoriesLoaded extends ApiState {
  final List<MyCategory> categories;

  CategoriesLoaded(this.categories);
}

class CategoriesError extends ApiState {
  final String message;

  CategoriesError(this.message);
}
