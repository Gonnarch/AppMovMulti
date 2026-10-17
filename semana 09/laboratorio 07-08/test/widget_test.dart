import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aula_violeta/app/aula_app.dart';

void main() {
  testWidgets('Valida el acceso y abre el menú docente', (tester) async {
    await tester.pumpWidget(const AulaApp());
    final submit = find.widgetWithText(FilledButton, 'Ingresar a mi aula  →');
    await tester.ensureVisible(submit);
    await tester.tap(submit);
    await tester.pump();
    expect(find.text('Ingresa un correo válido'), findsOneWidget);
    expect(find.text('Usa al menos 4 caracteres'), findsOneWidget);
    await tester.enterText(
      find.byType(TextFormField).at(0),
      'docente@aula.com',
    );
    await tester.enterText(find.byType(TextFormField).at(1), '1234');
    await tester.ensureVisible(submit);
    await tester.tap(submit);
    // El fondo se anima continuamente: se avanzan fotogramas sin pumpAndSettle.
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Hola, María ✨'), findsOneWidget);
    expect(find.text('Tu aula, a un toque'), findsOneWidget);
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
