import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_sample/core/models/user.dart';
import 'package:flutter_test_sample/pages/components/user_item_tile.dart';

void main() {

  group('UserItemTile tests', () {

    testWidgets('Test if name is visible', (tester) async {
      const user = User(
          id: 1,
          email: 'user@mail.com',
          firstName: 'User',
          lastName: 'User',
          avatar: '',
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: UserItemTile(
              user: user,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(user.email), findsOneWidget);
      expect(find.text('${user.firstName} ${user.lastName}'), findsOneWidget);
    });

  });

}