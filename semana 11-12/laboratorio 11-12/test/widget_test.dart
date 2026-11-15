import 'package:flutter_test/flutter_test.dart';

import 'package:lab1112/main.dart';

void main() {
  testWidgets('Muestra la pantalla de login', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Bienvenido'), findsOneWidget);
  });
}
