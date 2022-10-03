import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/provider/todo_list_provider.dart';
import 'package:todo_app/widgets/todo_item.dart';

class TodoList extends StatelessWidget {
  const TodoList() : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          // Remover essa linha e descomentar o conteúdo abaixo
          return Container();

          // return TodoItem(
          //   todo: todo,
          //   onCheckboxChanged: (complete) {
          //   },
          // );
        },
      ),
    );
  }
}
