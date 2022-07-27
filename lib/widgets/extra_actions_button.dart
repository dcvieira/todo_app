// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/enums.dart';
import 'package:todo_app/provider/todo_list_provider.dart';
import 'package:todo_app/util/app_keys.dart';

class ExtraActionsButton extends StatelessWidget {
  const ExtraActionsButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todoProvider = context.watch<TodoListProvider>();
    return PopupMenuButton<ExtraAction>(
      key: AppKeys.extraActionsButton,
      onSelected: (action) {
        if (action == ExtraAction.toggleAllComplete) {
          todoProvider.toggleAll();
        } else if (action == ExtraAction.clearCompleted) {
          todoProvider.clearCompleted();
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuItem<ExtraAction>>[
        PopupMenuItem<ExtraAction>(
          key: AppKeys.toggleAll,
          value: ExtraAction.toggleAllComplete,
          child: Text(
            todoProvider.allComplete
                ? 'Mark all incomplete'
                : 'Mark all complete',
          ),
        ),
        const PopupMenuItem<ExtraAction>(
          key: AppKeys.clearCompleted,
          value: ExtraAction.clearCompleted,
          child: Text('Clear completed'),
        ),
      ],
    );
  }
}
