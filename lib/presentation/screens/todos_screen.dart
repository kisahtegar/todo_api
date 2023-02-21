import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constans/strings.dart';
import '../../cubit/todos/todos_cubit.dart';
import '../../data/models/todo_model.dart';

class TodosScreen extends StatelessWidget {
  const TodosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TodosCubit>(context).fetchTodos();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Todos"),
        actions: [
          InkWell(
            onTap: () => Navigator.pushNamed(context, RouteConst.addTodoRoute),
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: BlocBuilder<TodosCubit, TodosState>(
        builder: (context, state) {
          if (state is TodosLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final todos = (state as TodosLoaded).todos;
          return SingleChildScrollView(
            child: Column(
              children: todos.map((e) => _todo(e, context)).toList(),
            ),
          );
        },
      ),
    );
  }

  // This Widget is list Todos.
  Widget _todo(TodoModel todo, context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        RouteConst.editTodoRoute,
        arguments: todo,
      ),
      child: Dismissible(
        key: Key("${todo.id}"),
        confirmDismiss: (_) async {
          BlocProvider.of<TodosCubit>(context).changeCompletion(todo);
          return false;
        },
        background: Container(
          color: Colors.indigo,
        ),
        child: _todoTile(todo, context),
      ),
    );
  }

  // This widget is todo card.
  Widget _todoTile(TodoModel todo, context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(todo.todoMessage),
          _completionIndicator(todo),
        ],
      ),
    );
  }

  // This widget is Cicular Indicator completed.
  Widget _completionIndicator(TodoModel todo) {
    return Container(
      width: 20.0,
      height: 20.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        border: Border.all(
          width: 4.0,
          color: todo.isCompleted ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}
