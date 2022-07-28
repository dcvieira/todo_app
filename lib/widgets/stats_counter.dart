import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/todo_list_provider.dart';
import 'package:todo_app/util/app_keys.dart';

class StatsCounter extends StatelessWidget {
  const StatsCounter() : super(key: AppKeys.statsCounter);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Completed Todos',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Consumer<TodoListProvider>(
              builder: (context, todoList, child) {
                return Text(
                  '${todoList.numCompleted}',
                  key: AppKeys.statsNumCompleted,
                  style: Theme.of(context).textTheme.subtitle1,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Active Todos',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Consumer<TodoListProvider>(
              builder: (context, todoList, child) {
                return Text(
                  '${todoList.numActive}',
                  key: AppKeys.statsNumActive,
                  style: Theme.of(context).textTheme.subtitle1,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
