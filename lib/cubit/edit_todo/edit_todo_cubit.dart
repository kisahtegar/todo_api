import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/todo_model.dart';

import '../../data/repository.dart';
import '../todos/todos_cubit.dart';

part 'edit_todo_state.dart';

class EditTodoCubit extends Cubit<EditTodoState> {
  final Repository? repository;
  final TodosCubit? todosCubit;

  EditTodoCubit({
    this.repository,
    this.todosCubit,
  }) : super(EditTodoInitial());

  /// Deleting todo [EditTodoCubit].
  void deleteTodo(TodoModel todo) {
    // Access [Repository] deleteTodo.
    repository!.deleteTodo(todo.id).then((isDeleted) {
      if (isDeleted!) {
        todosCubit!.deleteTodo(todo);
      }
    });
  }

  /// Editing todo [EditTodoCubit].
  void editTodo(TodoModel todo, String message) {
    // Checking if message no empty.
    if (message.isEmpty) {
      emit(EditTodoError(error: "Message is empty"));
      return;
    }

    // Access [Repository] editTodo.
    repository!.editTodo(message, todo.id).then((isEdited) {
      if (isEdited!) {
        todo.todoMessage = message;
        todosCubit!.updateTodoList();
        emit(EditTodoEdited());
      }
    });
  }
}
