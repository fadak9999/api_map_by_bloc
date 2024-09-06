
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
        emit(CategoriesLoaded(categories));
      } catch (e) {
        emit(CategoriesError(e.toString()));
      }
    });
  }
}
