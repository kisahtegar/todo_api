import 'package:flutter/material.dart';
import 'presentation/app_router.dart';

void main() => runApp(TodoApp(appRouter: AppRouter()));

class TodoApp extends StatelessWidget {
  final AppRouter appRouter;

  const TodoApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
