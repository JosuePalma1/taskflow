import '../domain/task.dart';
import 'task_repository.dart';

class LocalTaskRepository implements TaskRepository {
  final List<Task> _tasks = <Task>[
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
      description: 'Guardar capturas legibles de la lista y del detalle con estos datos.',
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

  @override
  Future<List<Task>> getTasks() async => List.unmodifiable(_tasks);

  @override
  void save(Task task) {
    final index = _tasks.indexWhere((item) => item.id == task.id);
    if (index == -1) return;
    _tasks[index] = task;
  }
}
