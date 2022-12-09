import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_sample/pages/components/user_item_tile.dart';
import 'package:integration_test/integration_test.dart';

import 'package:flutter_test_sample/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('verify the app ran properly',
            (tester) async {
          app.main();
          await tester.pumpAndSettle();

          expect(find.text('User list page'), findsOneWidget);

          await tester.tap(find.byType(UserItemTile).first);

          await tester.pumpAndSettle();

          expect(find.text('User detail page'), findsOneWidget);
        });
  });

}