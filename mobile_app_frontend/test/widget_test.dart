import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app_frontend/main.dart';
import 'package:mobile_app_frontend/app_state.dart';

void main() {
  testWidgets('App startup and tabs present', (WidgetTester tester) async {
    final appState = await AppState.load();
    await tester.pumpWidget(AudiolibraApp(appState: appState));

    // App launches and finds 3 tabs
    expect(find.byIcon(Icons.store), findsOneWidget);
    expect(find.byIcon(Icons.library_books), findsOneWidget);
    expect(find.byIcon(Icons.play_circle), findsOneWidget);

    // Store title exists
    expect(find.text('Audiobook Store'), findsOneWidget);
  });
}
