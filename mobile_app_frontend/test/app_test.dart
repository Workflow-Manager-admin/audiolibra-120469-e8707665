
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app_frontend/main.dart';
import 'package:mobile_app_frontend/models/app_state.dart';
import 'package:mobile_app_frontend/screens/store/store_screen.dart';
import 'package:mobile_app_frontend/screens/library/library_screen.dart';
import 'package:mobile_app_frontend/screens/player/player_screen.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('App initialization test', (WidgetTester tester) async {
    mockNetworkImagesFor(() async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (context) => AppState(),
          child: const MyApp(),
        ),
      );

      // Verify that the StoreScreen is displayed by default.
      expect(find.byType(StoreScreen), findsOneWidget);
      expect(find.byType(LibraryScreen), findsNothing);
      expect(find.byType(PlayerScreen), findsNothing);
    });
  });
}
