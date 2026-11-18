import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'task.dart';

void main() {
  runApp(const TaskFlowApp());
}

const demoTasks = <Task>[
  Task(
    id: 1,
    title: 'Especificar requisitos de TaskFlow',
    description: 'Definir usuario objetivo, historias, criterios y endpoints en el README.',
    priority: 'Alta',
    isCompleted: false,
    userId: 1,
  ),
  Task(
    id: 2,
    title: 'Validar navegación de lista y detalle',
    description: 'Abrir cada tarea desde el listado usando su id único.',
    priority: 'Alta',
    isCompleted: false,
    userId: 1,
  ),
  Task(
    id: 3,
    title: 'Documentar contrato JSON',
    description:
        'Incluir id, title, description, priority, isCompleted y userId.',
    priority: 'Media',
    isCompleted: false,
    userId: 1,
  ),
  Task(
    id: 4,
    title: 'Capturar evidencia de la aplicación',
    description:
        'Guardar capturas legibles de la lista y del detalle con estos datos.',
    priority: 'Media',
    isCompleted: false,
    userId: 1,
  ),
  Task(
    id: 5,
    title: 'Revisar el modelo Task',
    description:
        'Comprobar que el modelo representa sus seis campos y parsea JSON.',
    priority: 'Baja',
    isCompleted: true,
    userId: 1,
  ),
];

Task? findTask(int? id) {
  for (final task in demoTasks) {
    if (task.id == id) return task;
  }
  return null;
}

final appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const TaskListScreen()),
    GoRoute(
      path: '/task/:id',
      builder: (context, state) {
        final id = int.tryParse(state.pathParameters['id'] ?? '');
        return TaskDetailScreen(task: findTask(id));
      },
    ),
  ],
);

class TaskFlowApp extends StatelessWidget {
  const TaskFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'TaskFlow',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      routerConfig: appRouter,
    );
  }
}

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis tareas')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: demoTasks.length,
        itemBuilder: (context, index) {
          final task = demoTasks[index];
          return Card(
            child: ListTile(
              leading: Icon(
                task.isCompleted
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked,
              ),
              title: Text(task.title),
              subtitle: Text('Prioridad: ${task.priority}'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/task/${task.id}'),
            ),
          );
        },
      ),
    );
  }
}

class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({super.key, required this.task});

  final Task? task;

  @override
  Widget build(BuildContext context) {
    final selected = task;
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle de tarea')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: selected == null
            ? const Text('No se encontró esta tarea.')
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selected.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  Text(selected.description),
                  const SizedBox(height: 16),
                  Text('Prioridad: ${selected.priority}'),
                  Text(
                    selected.isCompleted
                        ? 'Estado: completada'
                        : 'Estado: pendiente',
                  ),
                  Text('Usuario: ${selected.userId}'),
                ],
              ),
      ),
    );
  }
}
