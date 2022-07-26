import '../models/todo.dart';

abstract class TodosRepository {
  Future<List<Todo>> loadTodos();

  // Persists todos to local disk and the web
  Future saveTodos(List<Todo> todos);
}
