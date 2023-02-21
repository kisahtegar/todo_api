import 'models/todo_model.dart';
import 'network_service.dart';

class Repository {
  final NetworkService? networkService;

  Repository({this.networkService});

  /// Fetching data todo from API `Repository()`.
  Future<List<TodoModel>> fetchTodos() async {
    final todosRaw = await networkService!.fetchTodos();
    return todosRaw.map((e) => TodoModel.fromJson(e)).toList();
  }

  /// Change data `{"isCompleted"}` todo API `Repository()`.
  Future<bool> changeCompletion(bool isCompleted, int id) async {
    final patchObj = {
      "isCompleted": isCompleted.toString(),
    };
    return await networkService!.patchTodo(patchObj, id);
  }

  /// Adding todo to API `Repository()`.
  Future<TodoModel?> addTodo(String message) async {
    final todoObj = {
      "todo": message,
      "isCompleted": "false",
    };

    // Accessing [NetworkService.addTodo()]
    final todoMap = await networkService!.addTodo(todoObj);
    if (todoMap == null) {
      return null;
    }

    return TodoModel.fromJson(todoMap);
  }

  /// Deleting todo API `Repository()`.
  Future<bool?> deleteTodo(int id) async {
    return await networkService!.deleteTodo(id);
  }

  /// Editing `{"todo": message}` API `Repository()`.
  Future<bool?> editTodo(String message, int id) async {
    final patchObj = {
      "todo": message,
    };
    return await networkService!.patchTodo(patchObj, id);
  }
}
