import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/edit_todo/edit_todo_cubit.dart';
import '../../data/models/todo_model.dart';

class EditTodoScreen extends StatelessWidget {
  final TodoModel todo;
  EditTodoScreen({super.key, required this.todo});

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Todo"),
        actions: [
          InkWell(
            onTap: () {
              /// Accessing [EditTodoCubit.deleteTodo()] then pop page.
              BlocProvider.of<EditTodoCubit>(context).deleteTodo(todo);
              Navigator.pop(context);
            },
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(Icons.delete),
            ),
          )
        ],
      ),
      body: _body(context),
    );
  }

  /// This widget is Body Page.
  Widget _body(context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            autocorrect: true,
            decoration:
                const InputDecoration(hintText: "Enter todo message..."),
          ),
          const SizedBox(height: 10.0),
          InkWell(
            onTap: () {
              BlocProvider.of<EditTodoCubit>(context)
                  .editTodo(todo, _controller.text);
              Future.delayed(const Duration(seconds: 5))
                  .then((value) => Navigator.pop(context));
            },
            child: _editButton(context),
          )
        ],
      ),
    );
  }

  /// This widget is Updating button.
  Widget _editButton(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: const Center(
        child: Text(
          "Update Todo",
          style: TextStyle(fontSize: 15.0, color: Colors.white),
        ),
      ),
    );
  }
}
