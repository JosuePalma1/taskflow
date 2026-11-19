import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:taskflow/app/taskflow_app.dart';
import 'package:taskflow/features/tasks/data/local_task_repository.dart';
import 'package:taskflow/features/tasks/presentation/tasks_view_model.dart';

void main() {
  testWidgets('muestra la lista y el detalle de una tarea', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => TasksViewModel(LocalTaskRepository()),
        child: const TaskFlowApp(),
      ),
    );

    expect(find.text('Mis tareas'), findsOneWidget);
    expect(find.text('Especificar requisitos de TaskFlow'), findsOneWidget);

    await tester.tap(find.text('Especificar requisitos de TaskFlow'));
    await tester.pumpAndSettle();

    expect(find.text('Detalle de tarea'), findsOneWidget);
    expect(
      find.text(
        'Definir usuario objetivo, historias, criterios y endpoints en el README.',
      ),
      findsOneWidget,
    );
    expect(find.text('Prioridad: Alta'), findsOneWidget);
    expect(find.text('Estado: pendiente'), findsOneWidget);

    await tester.tap(find.text('Marcar como completada'));
    await tester.pumpAndSettle();
    expect(find.text('Estado: completada'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Mis tareas'), findsOneWidget);
  });
}
