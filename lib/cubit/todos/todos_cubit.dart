import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/todo_model.dart';
import '../../data/repository.dart';

part 'todos_state.dart';

class TodosCubit extends Cubit<TodosState> {
  final Repository? repository;

  TodosCubit({this.repository}) : super(TodosInitial());

  /// Fetch Todo [TodosCubit].
  void fetchTodos() {
    emit(TodosLoading());
    Timer(const Duration(seconds: 3), () {
      // Access [Repository] to fetchTodos().
      repository!.fetchTodos().then((todos) {
        emit(TodosLoaded(todos: todos));
      });
    });
  }

  /// Change isCompleted [TodosCubit].
  void changeCompletion(TodoModel todo) {
    // Access [Repository] to changeCompletion().
    repository!.changeCompletion(!todo.isCompleted, todo.id).then((isChanged) {
      if (isChanged) {
        todo.isCompleted = !todo.isCompleted;
        updateTodoList();
      }
    });
  }

  /// Updating list of Todo [TodosCubit].
  void updateTodoList() {
    final currentState = state;
    if (currentState is TodosLoaded) {
      emit(TodosLoaded(todos: currentState.todos));
    }
  }

  /// Adding Todo [TodosCubit].
  void addTodo(todo) {
    final currentState = state;
    if (currentState is TodosLoaded) {
      final todoList = currentState.todos;
      todoList.add(todo);
      emit(TodosLoaded(todos: todoList));
    }
  }

  /// Deleting Todo [TodosCubit].
  void deleteTodo(TodoModel todo) {
    final currentState = state;
    if (currentState is TodosLoaded) {
      final todoList =
          currentState.todos.where((element) => element.id != todo.id).toList();
      emit(TodosLoaded(todos: todoList));
    }
  }
}
