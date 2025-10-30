import 'package:flutter_test/flutter_test.dart';
import 'package:challengefluttergreengo/main.dart';

void main() {
  testWidgets('La app se construye y muestra el título', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Título localizado (depende del locale del host; asumimos 'es')
    expect(find.textContaining('GreenGo Logistics'), findsWidgets);
  });
}
