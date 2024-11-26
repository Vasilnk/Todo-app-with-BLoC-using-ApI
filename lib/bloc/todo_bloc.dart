import 'package:flutter_bloc/flutter_bloc.dart';
import 'todo_event.dart';
import 'todo_state.dart';
import '../api/api_services.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final ApiServices apiServices;

  TodoBloc(this.apiServices) : super(TodoInitial()) {
    on<FetchTodos>((event, emit) async {
      emit(TodoLoading());
      try {
        final result = await apiServices.getAllTodo();
        final reversedTodos = (result.items ?? []).reversed.toList();
        emit(TodoLoaded(reversedTodos));
      } catch (e) {
        emit(TodoError('Failed to fetch todos'));
      }
    });

    on<AddTodo>((event, emit) async {
      try {
        await apiServices.addTodo(
            event.title, event.description, event.isCompleted);
        add(FetchTodos());
      } catch (e) {
        emit(TodoError('Failed to add todo: $e'));
        throw Exception("Error adding todo: $e");
      }
    });
  }
}
