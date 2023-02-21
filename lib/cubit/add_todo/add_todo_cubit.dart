import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../todos/todos_cubit.dart';
import '../../data/repository.dart';

part 'add_todo_state.dart';

class AddTodoCubit extends Cubit<AddTodoState> {
  final Repository? repository;
  final TodosCubit? todosCubit;

  AddTodoCubit({
    this.repository,
    this.todosCubit,
  }) : super(AddTodoInitial());

  /// Adding todo cubit [AddTodoCubit].
  void addTodo(String message) {
    // Checking if message no empty.
    if (message.isEmpty) {
      emit(AddTodoError(error: "todo message is empty"));
      return;
    }

    // Emit loading
    emit(AddTodoAdding());

    Timer(const Duration(seconds: 2), () {
      // Access repository editTodo.
      repository!.addTodo(message).then((todo) {
        if (todo != null) {
          // Access [TodosCubit] editTodo.
          todosCubit!.addTodo(todo);
          emit(AddTodoAdded());
        }
      });
    });
  }
}
