import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/add_todo/add_todo_cubit.dart';

import '../cubit/todos/todos_cubit.dart';
import '../data/models/todo_model.dart';
import '../data/network_service.dart';
import 'screens/add_todo_screen.dart';
import 'screens/edit_todo_screen.dart';
import 'screens/todos_screen.dart';

import '../constans/strings.dart';
import '../cubit/edit_todo/edit_todo_cubit.dart';
import '../data/repository.dart';

class AppRouter {
  Repository? repository;
  TodosCubit? todosCubit;

  AppRouter() {
    repository = Repository(networkService: NetworkService());
    todosCubit = TodosCubit(repository: repository);
  }

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: todosCubit!,
            child: const TodosScreen(),
          ),
        );

      case RouteConst.addTodoRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AddTodoCubit(
              repository: repository,
              todosCubit: todosCubit,
            ),
            child: AddTodoScreen(),
          ),
        );

      case RouteConst.editTodoRoute:
        final todo = settings.arguments as TodoModel;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => EditTodoCubit(
              repository: repository,
              todosCubit: todosCubit,
            ),
            child: EditTodoScreen(
              todo: todo,
            ),
          ),
        );

      default:
        return MaterialPageRoute(builder: (_) => const NotFoundPage());
    }
  }
}

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
