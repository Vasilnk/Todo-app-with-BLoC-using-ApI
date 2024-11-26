import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todo_with_bloc/api/api_model/get_all_todo_model.dart';
import 'package:todo_with_bloc/api/api_model/todo_model.dart';

class ApiServices {
  final baseUrl = 'https://api.nstack.in';
  Future<GetAllTodoModel> getAllTodo() async {
    final response = await http.get(Uri.parse('$baseUrl/v1/todos'));

    if (response.statusCode == 200) {
      return GetAllTodoModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error');
    }
  }

  Future<TodoModel> addTodo(
      String title, String description, bool isCompleted) async {
    final response = await http.post(Uri.parse('$baseUrl/v1/todos'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "title": title,
          "description": description,
          "is_completed": isCompleted
        }));

    if (response.statusCode == 201) {
      print('Request success');
      return TodoModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error');
    }
  }
}
