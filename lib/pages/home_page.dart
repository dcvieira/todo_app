import 'package:flutter/material.dart';
import 'package:todo_app/models/app_state.dart';
import 'package:todo_app/models/enums.dart';
import 'package:todo_app/models/typedefs.dart';
import 'package:todo_app/util/app_keys.dart';
import 'package:todo_app/widgets/extra_actions_button.dart';
import 'package:todo_app/widgets/filter_button.dart';
import 'package:todo_app/widgets/stats_counter.dart';
import 'package:todo_app/widgets/todo_list.dart';

class HomePage extends StatefulWidget {
  final AppState appState;
  final TodoAdder addTodo;
  final TodoRemover removeTodo;
  final TodoUpdater updateTodo;
  final Function toggleAll;
  final Function clearCompleted;

  const HomePage({
    required this.appState,
    required this.addTodo,
    required this.removeTodo,
    required this.updateTodo,
    required this.toggleAll,
    required this.clearCompleted,
  }) : super(key: AppKeys.homeScreen);

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  VisibilityFilter activeFilter = VisibilityFilter.all;
  AppTab activeTab = AppTab.todos;

  void _updateVisibility(VisibilityFilter filter) {
    setState(() {
      activeFilter = filter;
    });
  }

  void _updateTab(AppTab tab) {
    setState(() {
      activeTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        actions: [
          FilterButton(
            isActive: activeTab == AppTab.todos,
            activeFilter: activeFilter,
            onSelected: _updateVisibility,
          ),
          ExtraActionsButton(
            allComplete: widget.appState.allComplete,
            hasCompletedTodos: widget.appState.hasCompletedTodos,
            onSelected: (action) {
              if (action == ExtraAction.toggleAllComplete) {
                widget.toggleAll();
              } else if (action == ExtraAction.clearCompleted) {
                widget.clearCompleted();
              }
            },
          )
        ],
      ),
      body: activeTab == AppTab.todos
          ? TodoList(
              filteredTodos: widget.appState.filteredTodos(activeFilter),
              loading: widget.appState.isLoading,
              removeTodo: widget.removeTodo,
              addTodo: widget.addTodo,
              updateTodo: widget.updateTodo,
            )
          : StatsCounter(
              numActive: widget.appState.numActive,
              numCompleted: widget.appState.numCompleted,
            ),
      floatingActionButton: FloatingActionButton(
        key: AppKeys.addTodoFab,
        onPressed: () {
          Navigator.pushNamed(context, '/addTodo');
        },
        tooltip: 'Add Todo',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        key: AppKeys.tabs,
        currentIndex: AppTab.values.indexOf(activeTab),
        onTap: (index) {
          _updateTab(AppTab.values[index]);
        },
        items: AppTab.values.map((tab) {
          return BottomNavigationBarItem(
            icon: Icon(
              tab == AppTab.todos ? Icons.list : Icons.show_chart,
              key: tab == AppTab.stats ? AppKeys.statsTab : AppKeys.todoTab,
            ),
            label: tab == AppTab.stats ? 'Stats' : 'Todos',
          );
        }).toList(),
      ),
    );
  }
}
