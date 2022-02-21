import 'dart:io';
import 'package:flutter/material.dart';
import 'package:todo_list/core/core.dart';

import '../screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        backgroundColor: KColors.white,
        appBar: appBar(context),
        floatingActionButton: floatingButton(context),
        body: List(),
      ),
    );
  }

  FloatingActionButton floatingButton(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (_) => AddNewTask(isEditMode: false),
        );
      },
      tooltip: 'Add Todo!',
    );
  }

  Future<bool> _onWillPop() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text('Are you sure about this?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(
              'NO',
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
          TextButton(
            onPressed: () => exit(0),
            child: const Text(
              'YES',
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: const Text('TO DO LIST'),
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {},
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (_) => AddNewTask(isEditMode: false),
            );
          },
        ),
      ],
    );
  }
}
