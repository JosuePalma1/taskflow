import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:taskflow/main.dart';

void main() {
  testWidgets('muestra la bienvenida personalizada de TaskFlow', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const TaskFlowApp());

    expect(find.text('¡Hola, Josue!'), findsOneWidget);
    expect(
      find.text('Organiza tus tareas y alcanza tus metas.'),
      findsOneWidget,
    );
    expect(find.byIcon(Icons.task_alt), findsOneWidget);
  });
}
