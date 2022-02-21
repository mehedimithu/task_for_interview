import 'package:flutter/material.dart';

class TodoModel {
  final String id;
  String description;
  DateTime? dueDate;
  TimeOfDay? dueTime;
  bool isDone;

  TodoModel({
    required this.id,
    required this.description,
    this.dueDate,
    this.dueTime,
    this.isDone = false,
  });
}
