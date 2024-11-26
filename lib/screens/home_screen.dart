import 'package:flutter/material.dart';
import 'package:todo_with_bloc/api/api_services.dart';
import 'package:todo_with_bloc/screens/add_screen.dart';
import 'package:todo_with_bloc/widgets/list_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> complete = [];
  List<dynamic> inComplete = [];
  List<dynamic> allData = [];
  bool isLoading = false;
  Future<void> getAllTodo() async {
    setState(() => isLoading = true);

    final result = await ApiServices().getAllTodo();

    final todos = result.items ?? [];
    allData = todos.toList();
    complete = todos.where((todo) => todo.isCompleted == true).toList();
    inComplete = todos.where((todo) => todo.isCompleted == false).toList();

    setState(() => isLoading = false);
  }

  @override
  void initState() {
    getAllTodo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : TabBarView(
                children: [
                  CustomListView(
                    todoList: allData,
                  ),
                  CustomListView(
                    todoList: complete,
                  ),
                  CustomListView(
                    todoList: inComplete,
                  ),
                ],
              ),
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
