
import 'package:api_map_by_bloc/MODEL/model.dart';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:api_map_by_bloc/API/ApiService.dart';


part 'api_event.dart';
part 'api_state.dart';




class ApiBloc extends Bloc<ApiEvent, ApiState> {
  final ApiService apiService;

  ApiBloc(this.apiService) : super(ApiInitial()) {
    on<FetchCategories>((event, emit) async {
      emit(CategoriesLoading());
      try {
        final categories = await apiService.fetchCategories();
        print('Fetched Categories: ${categories.length}'); // Debug print
        if (categories.isEmpty) {
          emit(CategoriesError('No categories found.'));
        } else {
          emit(CategoriesLoaded(categories));
        }
      } catch (e) {
        print('Error fetching categories: $e'); // Debug print
        emit(CategoriesError('Failed to fetch categories. Please check your connection.'));
      }
    });
  }
}
