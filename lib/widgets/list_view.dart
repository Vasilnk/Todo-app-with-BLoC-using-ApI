import 'package:flutter/material.dart';

class CustomListView extends StatelessWidget {
  final List<dynamic> todoList;
  const CustomListView({super.key, required this.todoList});

  @override
  Widget build(BuildContext context) {
    return todoList.isEmpty
        ? const Center(
            child: Text("No item"),
          )
        : ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: todoList.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final item = todoList[index];
              return Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.title!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Chip(
                            label: Text(
                              item.isCompleted! ? 'Complete' : 'incomplete',
                              style: TextStyle(
                                color: item.isCompleted!
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                            backgroundColor: item.isCompleted!
                                ? Colors.green[100]
                                : Colors.red[100],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.description!,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
