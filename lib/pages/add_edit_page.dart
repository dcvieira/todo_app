import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/provider/todo_list_provider.dart';
import 'package:todo_app/util/app_keys.dart';

class AddEditPage extends StatefulWidget {
  final Todo? todo;

  const AddEditPage({
    Key? key,
    this.todo,
  }) : super(key: key ?? AppKeys.addTodoScreen);

  @override
  _AddEditPageState createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? _task;
  String? _note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? 'Edit Todo' : 'Edit Todo',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          onWillPop: () {
            return Future(() => true);
          },
          child: ListView(
            children: [
              TextFormField(
                initialValue: widget.todo != null ? widget.todo!.task : '',
                key: AppKeys.taskField,
                autofocus: isEditing ? false : true,
                style: Theme.of(context).textTheme.headline5,
                decoration: const InputDecoration(
                  hintText: 'What needs to be done?',
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (value) => _task = value!,
              ),
              TextFormField(
                initialValue: widget.todo != null ? widget.todo!.note : '',
                key: AppKeys.noteField,
                maxLines: 10,
                style: Theme.of(context).textTheme.subtitle1,
                decoration: const InputDecoration(
                  hintText: 'Additional Notes...',
                ),
                onSaved: (value) => _note = value ?? '',
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          key: isEditing ? AppKeys.saveTodoFab : AppKeys.saveNewTodo,
          tooltip: isEditing ? 'Save changes' : 'Edit Todo',
          child: Icon(isEditing ? Icons.check : Icons.add),
          onPressed: () {
            final form = formKey.currentState;
            if (form!.validate()) {
              form.save();

              final todoProvider = context.read<TodoListProvider>();
              if (isEditing) {
                todoProvider.updateTodo(
                    widget.todo!.copyWith(task: _task, note: _note));
              } else {
                todoProvider.addTodo(Todo(_task!, note: _note ?? ''));
              }

              Navigator.pop(context);
            }
          }),
    );
  }

  bool get isEditing => widget.todo != null;
}
