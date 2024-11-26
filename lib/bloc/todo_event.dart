import 'package:equatable/equatable.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object?> get props => [];
}

class FetchTodos extends TodoEvent {}

class AddTodo extends TodoEvent {
  final String title;
  final String description;
  final bool isCompleted;

  const AddTodo(this.title, this.description, this.isCompleted);

  @override
  List<Object?> get props => [title, description, isCompleted];
}
