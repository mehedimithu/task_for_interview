import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/core/core.dart';
import 'package:todo_list/data/model/todo_model.dart';
import 'package:todo_list/logic/logic.dart';

class AddNewTask extends StatefulWidget {
  String? id;
  bool? isEditMode;

  AddNewTask({
    this.id,
    this.isEditMode,
  });

  @override
  _AddNewTaskState createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  TodoModel? task;
  TimeOfDay? _selectedTime;
  DateTime? _selectedDate;
  String? _inputDescription;
  final _formKey = GlobalKey<FormState>();

  void _pickUserDueDate() {
    showDatePicker(
            context: context,
            initialDate: widget.isEditMode! ? _selectedDate! : DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2030))
        .then((date) {
      if (date == null) {
        return;
      }
      date = date;
      setState(() {
        _selectedDate = date;
      });
    });
  }

  void _pickUserDueTime() {
    showTimePicker(
      context: context,
      initialTime: widget.isEditMode! ? _selectedTime! : TimeOfDay.now(),
    ).then((time) {
      if (time == null) {
        return;
      }
      setState(() {
        _selectedTime = time;
      });
    });
  }

  void _validateForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_selectedDate == null && _selectedTime != null) {
        _selectedDate = DateTime.now();
      }
      if (!widget.isEditMode!) {
        Provider.of<TodoProvider>(context, listen: false).createNewTask(
          TodoModel(
            id: DateTime.now().toString(),
            description: _inputDescription!,
            dueDate: _selectedDate,
            dueTime: _selectedTime,
          ),
        );
      } else {
        Provider.of<TodoProvider>(context, listen: false).editTask(
          TodoModel(
            id: task!.id,
            description: _inputDescription!,
            dueDate: _selectedDate,
            dueTime: _selectedTime,
          ),
        );
      }
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    if (widget.isEditMode!) {
      task =
          Provider.of<TodoProvider>(context, listen: false).getById(widget.id!);
      _selectedDate = task!.dueDate;
      _selectedTime = task!.dueTime;
      _inputDescription = task!.description;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Title', style: Theme.of(context).textTheme.subtitle1),
            TextFormField(
              initialValue: _inputDescription,
              decoration: const InputDecoration(
                hintText: 'Describe your todo',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter something';
                }
                return null;
              },
              onSaved: (value) {
                _inputDescription = value;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Text('Due Date', style: Theme.of(context).textTheme.subtitle1),
            TextFormField(
              onTap: () {
                _pickUserDueDate();
              },
              readOnly: true,
              decoration: InputDecoration(
                hintText: _selectedDate == null
                    ? 'Provide your due date'
                    : DateFormat.yMMMd().format(_selectedDate!).toString(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text('Due Time', style: Theme.of(context).textTheme.subtitle1),
            TextFormField(
              onTap: () {
                _pickUserDueTime();
              },
              readOnly: true,
              decoration: InputDecoration(
                hintText: _selectedTime == null
                    ? 'Provide your due time'
                    : _selectedTime!.format(context),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                child: Text(
                  !widget.isEditMode! ? 'ADD TODO' : 'EDIT TODO',
                  style: const TextStyle(
                      color: KColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.redAccent),
                ),
                onPressed: () {
                  _validateForm();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
