import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_alchermix/screens/concept_lab_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Fuse button navigates or shows setup when inputs valid', (tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const MaterialApp(home: ConceptLabScreen()));

    await tester.enterText(find.byType(TextField).at(0), 'Idea A');
    await tester.enterText(find.byType(TextField).at(1), 'Idea B');
    await tester.pump();

    final fuseButton = find.text('FUSE CONCEPTS');
    await tester.ensureVisible(fuseButton);
    await tester.tap(fuseButton);
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.text('API Configuration'), findsOneWidget);
  });
}
