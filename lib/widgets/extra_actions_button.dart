import 'package:flutter/material.dart';
import 'package:todo_app/models/enums.dart';

class ExtraActionsButton extends StatelessWidget {
  const ExtraActionsButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ExtraAction>(
      onSelected: (action) {
        // Verificar o tipo de ação e utilizar os métodos adequados no TodoProvider
        print(action);
      },
      itemBuilder: (BuildContext context) => <PopupMenuItem<ExtraAction>>[
        const PopupMenuItem<ExtraAction>(
          value: ExtraAction.completeAll,
          child: Text('Completar Todos'),
        ),
        const PopupMenuItem<ExtraAction>(
          value: ExtraAction.clearCompleted,
          child: Text('Limpar completos'),
        ),
      ],
    );
  }
}
