import 'package:todo_app/util/uuid.dart';

class Todo {
  bool complete;
  String? id;
  String note;
  String task;

  Todo(this.task, {this.complete = false, this.note = '', String? id})
      : id = id ?? Uuid().generateV4();

  @override
  int get hashCode =>
      complete.hashCode ^ task.hashCode ^ note.hashCode ^ id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Todo &&
          runtimeType == other.runtimeType &&
          complete == other.complete &&
          task == other.task &&
          note == other.note &&
          id == other.id;

  @override
  String toString() {
    return 'Todo{complete: $complete, task: $task, note: $note, id: $id}';
  }

  Map<String, Object> toJson() {
    return {
      'complete': complete,
      'task': task,
      'note': note,
      'id': id ?? '',
    };
  }

  static Todo fromJson(Map<String, dynamic> json) {
    return Todo(
      json['task'] as String,
      id: json['id'] as String,
      note: json['note'] as String,
      complete: json['complete'] as bool,
    );
  }
}
