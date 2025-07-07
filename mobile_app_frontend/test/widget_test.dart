import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app_frontend/main.dart';

void main() {
  testWidgets('App loads main navigation', (WidgetTester tester) async {
    await tester.pumpWidget(const AudiolibraApp());
    expect(find.text('Store'), findsOneWidget);
    expect(find.text('Library'), findsOneWidget);
    expect(find.text('Player'), findsOneWidget);
  });
}
