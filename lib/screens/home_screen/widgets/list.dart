import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/core/core.dart';
import 'package:todo_list/logic/logic.dart';

import '../../screens.dart';

class List extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskList = Provider.of<TodoProvider>(context).itemsList;
    return taskList.isNotEmpty
        ? ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (context, index) {
              return ListItem(taskList[index]);
            },
          )
        : LayoutBuilder(
            builder: (ctx, constraints) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: constraints.maxHeight * 0.5,
                      child: Image.asset(KAssets.emptyTodo, fit: BoxFit.cover),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'ToDo List is Empty',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
              );
            },
          );
  }
}
