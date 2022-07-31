import 'package:flutter/material.dart';
import 'package:todo_app/models/enums.dart';
import 'package:todo_app/util/app_keys.dart';
import 'package:todo_app/widgets/extra_actions_button.dart';
import 'package:todo_app/widgets/filter_button.dart';
import 'package:todo_app/widgets/stats_counter.dart';
import 'package:todo_app/widgets/todo_list.dart';

class HomePage extends StatefulWidget {
  const HomePage() : super(key: AppKeys.homeScreen);

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  AppTab activeTab = AppTab.todos;

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
          ),
          const ExtraActionsButton()
        ],
      ),
      body: activeTab == AppTab.todos ? const TodoList() : const StatsCounter(),
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
