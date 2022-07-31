import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/enums.dart';
import 'package:todo_app/provider/todo_list_provider.dart';
import 'package:todo_app/util/app_keys.dart';

class FilterButton extends StatelessWidget {
  final bool isActive;

  const FilterButton({required this.isActive, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultStyle = Theme.of(context).textTheme.bodyText1;
    final activeStyle = Theme.of(context)
        .textTheme
        .bodyText1!
        .copyWith(color: Theme.of(context).colorScheme.secondary);
    final button = _Button(
      activeStyle: activeStyle,
      defaultStyle: defaultStyle!,
    );

    return AnimatedOpacity(
      opacity: isActive ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 150),
      child: isActive ? button : IgnorePointer(child: button),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    Key? key,
    required this.activeStyle,
    required this.defaultStyle,
  }) : super(key: key);

  final TextStyle activeStyle;
  final TextStyle defaultStyle;

  @override
  Widget build(BuildContext context) {
    final todoProvider = context.watch<TodoListProvider>();
    return PopupMenuButton<VisibilityFilter>(
      key: AppKeys.filterButton,
      tooltip: 'Filter Todos',
      initialValue: todoProvider.filter,
      onSelected: (filter) => todoProvider.filter = filter,
      itemBuilder: (BuildContext context) => <PopupMenuItem<VisibilityFilter>>[
        PopupMenuItem<VisibilityFilter>(
          key: AppKeys.allFilter,
          value: VisibilityFilter.all,
          child: Text(
            'Show All',
            style: todoProvider.filter == VisibilityFilter.all
                ? activeStyle
                : defaultStyle,
          ),
        ),
        PopupMenuItem<VisibilityFilter>(
          key: AppKeys.activeFilter,
          value: VisibilityFilter.active,
          child: Text(
            'Show Active',
            style: todoProvider.filter == VisibilityFilter.active
                ? activeStyle
                : defaultStyle,
          ),
        ),
        PopupMenuItem<VisibilityFilter>(
          key: AppKeys.completedFilter,
          value: VisibilityFilter.completed,
          child: Text(
            'Show Completed',
            style: todoProvider.filter == VisibilityFilter.completed
                ? activeStyle
                : defaultStyle,
          ),
        ),
      ],
      icon: const Icon(Icons.filter_list),
    );
  }
}
