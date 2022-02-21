import 'package:flutter/material.dart';
import 'package:todo_list/data/data.dart';

class TodoProvider with ChangeNotifier {
  List<TodoModel> get itemsList {
    return _toDoList;
  }

  final List<TodoModel> _toDoList = [
    TodoModel(
      id: 'task#1',
      description: 'Test 1 todo list',
      dueDate: DateTime.now(),
      dueTime: TimeOfDay.now(),
    ),
    TodoModel(
      id: 'task#2',
      description: 'Test 2 todo list',
      dueDate: DateTime.now(),
      dueTime: TimeOfDay.now(),
    ),
  ];

  TodoModel getById(String id) {
    return _toDoList.firstWhere((task) => task.id == id);
  }

  void createNewTask(TodoModel task) {
    final newTask = TodoModel(
      id: task.id,
      description: task.description,
      dueDate: task.dueDate,
      dueTime: task.dueTime,
    );
    _toDoList.add(newTask);
    notifyListeners();
  }

  void editTask(TodoModel task) {
    removeTask(task.id);
    createNewTask(task);
  }

  void removeTask(String id) {
    _toDoList.removeWhere((task) => task.id == id);
    notifyListeners();
  }

  void changeStatus(String id) {
    int index = _toDoList.indexWhere((task) => task.id == id);
    _toDoList[index].isDone = !_toDoList[index].isDone;
  }
}
