// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:todo_app/models/enums.dart';
import 'package:todo_app/util/app_keys.dart';

class ExtraActionsButton extends StatelessWidget {
  final PopupMenuItemSelected<ExtraAction> onSelected;
  final bool allComplete;
  final bool hasCompletedTodos;

  const ExtraActionsButton({
    required this.onSelected,
    this.allComplete = false,
    this.hasCompletedTodos = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ExtraAction>(
      key: AppKeys.extraActionsButton,
      onSelected: onSelected,
      itemBuilder: (BuildContext context) => <PopupMenuItem<ExtraAction>>[
        PopupMenuItem<ExtraAction>(
          key: AppKeys.toggleAll,
          value: ExtraAction.toggleAllComplete,
          child: Text(
            allComplete ? 'Mark all incomplete' : 'Mark all complete',
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
