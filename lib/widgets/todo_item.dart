import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';

class TodoItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final ValueChanged<bool?> onCheckboxChanged;
  final Todo todo;

  const TodoItem({
    Key? key,
    required this.onDismissed,
    required this.onCheckboxChanged,
    required this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo.id ?? ''),
      onDismissed: onDismissed,
      child: ListTile(
        onTap: () {},
        leading: Checkbox(
          value: todo.complete,
          onChanged: onCheckboxChanged,
        ),
        title: Text(
          todo.task,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          todo.note,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
    );
  }
}
