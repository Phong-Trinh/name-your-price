import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:name_your_price/pages/home_page.dart';

void main() {
  group('Home page test', () {
    Finder checkBtn() => find.text('Check');
    Finder nextBtn() => find.text('Next');
    Finder priceInput() => find.byType(TextField);

    testWidgets('Change product name after each click', (widgetTester) async {
      await widgetTester.pumpWidget(const MaterialApp(
        home: HomePage(),
      ));

      expect(find.text(products[0].name), findsOneWidget);

      for (var i = 1; i < products.length; i++) {
        await widgetTester.enterText(priceInput(), '3');
        await widgetTester.tap(checkBtn());
        await widgetTester.pump();
        await widgetTester.tap(nextBtn());
        await widgetTester.pump();
        expect(find.text(products[i].name), findsOneWidget);
      }

      await widgetTester.enterText(priceInput(), '3');
      await widgetTester.tap(checkBtn());
      await widgetTester.pump();
      await widgetTester.tap(nextBtn());
      await widgetTester.pump();
      expect(find.text(products.last.name), findsOneWidget);
    });

    testWidgets('Check result & show next product', (widgetTester) async {
      await widgetTester.pumpWidget(const MaterialApp(home: HomePage()));

      expect(nextBtn(), findsNothing);
      expect(find.text('pass'), findsNothing);
      expect(find.text('fail'), findsNothing);

      await widgetTester.enterText(priceInput(), '3');
      await widgetTester.tap(checkBtn());
      await widgetTester.pump();
      expect(find.text('pass'), findsOneWidget);

      await widgetTester.tap(nextBtn());
      await widgetTester.pump();

      await widgetTester.enterText(priceInput(), '3');
      await widgetTester.tap(checkBtn());
      await widgetTester.pump();
      expect(find.text('fail'), findsOneWidget);

      await widgetTester.enterText(priceInput(), '5');
      await widgetTester.tap(checkBtn());
      await widgetTester.pump();
      expect(find.text('pass'), findsOneWidget);
    });
  });
}
