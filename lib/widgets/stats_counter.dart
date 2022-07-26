import 'package:flutter/material.dart';
import 'package:todo_app/util/app_keys.dart';

class StatsCounter extends StatelessWidget {
  final int numActive;
  final int numCompleted;

  const StatsCounter({required this.numActive, required this.numCompleted})
      : super(key: AppKeys.statsCounter);

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
            child: Text(
              '$numCompleted',
              key: AppKeys.statsNumCompleted,
              style: Theme.of(context).textTheme.subtitle1,
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
            child: Text(
              '$numActive',
              key: AppKeys.statsNumActive,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          )
        ],
      ),
    );
  }
}
