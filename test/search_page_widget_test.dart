import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_weather_stream_bloc/pages/search_page.dart';

void main() {
  group('SearchPage Widget Tests', () {
    testWidgets('Check for Search...', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: SearchPage(),
        ),
      );
      // Act
      Finder title = find.text('Search...');
      // Assert
      expect(title, findsOneWidget);
    });
    testWidgets('Check for HintText', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: SearchPage(),
        ),
      );
      // Act
      Finder hintText = find.text('Must be more than 2 characters');
      // Assert
      expect(hintText, findsOneWidget);
    });
    testWidgets('Form Widget Test', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: SearchPage(),
        ),
      );
      // Act
      Finder formFinder = find.byType(Form);
      // Assert
      expect(formFinder, findsOneWidget);
    });
  });
}
