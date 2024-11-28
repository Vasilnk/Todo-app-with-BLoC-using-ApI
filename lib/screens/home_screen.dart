import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_with_bloc/bloc/todo_bloc.dart';
import 'package:todo_with_bloc/bloc/todo_event.dart';
import 'package:todo_with_bloc/bloc/todo_state.dart';
import 'package:todo_with_bloc/screens/add_screen.dart';
import 'package:todo_with_bloc/widgets/list_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TodoBloc>().add(FetchTodos());
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Complete'),
              Tab(text: 'Incomplete'),
            ],
          ),
        ),
        body: BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TodoLoaded) {
            return TabBarView(
              children: [
                CustomListView(todoList: state.todos),
                CustomListView(
                    todoList:
                        state.todos.where((todo) => todo.isCompleted).toList()),
                CustomListView(
                    todoList: state.todos
                        .where((todo) => !todo.isCompleted)
                        .toList()),
              ],
            );
          } else if (state is TodoError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text("No data"));
          }
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddScreen()),
            );
          },
          backgroundColor: const Color.fromARGB(255, 37, 88, 83),
          child: const Icon(Icons.add, color: Colors.white),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
