import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/repository/todos_repository.dart';

/// Loads and saves a List of Todos using a provided KeyValueStore, which works
/// on mobile and web. On mobile, it uses the SharedPreferences package, on web
/// it uses window.localStorage.
///
/// Can be used as it's own repository, or mixed together with other storage
/// solutions, such as the the WebClient, which can be seen in the
/// LocalStorageRepository.
class LocalStorageRepository implements TodosRepository {
  final String _key = 'todos';
  SharedPreferences? _store;

  LocalStorageRepository();

  Future<SharedPreferences> loadStore() async {
    if (_store != null) {
      return _store!;
    }

    return await SharedPreferences.getInstance();
  }

  @override
  Future<List<Todo>> loadTodos() async {
    final store = await loadStore();
    return json
        .decode(store.getString(_key) ?? '')['todos']
        .cast<Map<String, Object>>()
        .map<Todo>(Todo.fromJson)
        .toList();
  }

  @override
  Future<bool> saveTodos(List<Todo> todos) async {
    final store = await loadStore();
    return store.setString(
      _key,
      json.encode({
        'todos': todos.map((todo) => todo.toJson()).toList(),
      }),
    );
  }
}
