import 'package:flutter/material.dart';
import 'package:flutter_integration_test/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  debugPrint(" 🐞🐞🐞  Testing started! 🐞🐞🐞");
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    "🪲🪲 If there is no text in the input field, there will be an error!If validation is ok, then there will be none! 🪲🪲\n",
    (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      //Tapping the floating action button!
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      //We will now looking for homepage and not expecting MySecondPage
      expect(find.byType(MyHomePage), findsOneWidget);
      expect(find.byType(MySecondPage), findsNothing);

      //Expecting error text from validation!
      expect(find.text('You can not leave this empty'), findsOneWidget);
    },
  );

  testWidgets(
      "🪲🪲 This will Type text and will go to mysecondpage and then will be back from second page and then text editor controller will be empty 🪲🪲",
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    //Entering the text in text input filed!
    const inputText = "hello meow";
    await tester.enterText(
        find.byKey(const Key(("text_field_key"))), inputText);

    //Tapping the floating action button!
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    //We will now looking for MySecondPage and not expecting MyHomePage
    expect(find.byType(MyHomePage), findsNothing);
    expect(find.byType(MySecondPage), findsWidgets);
    // expect(find.text(inputText), findsOneWidget);

    //back from the MySecondPage and we expect textEditor will be empty,
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.text(inputText), findsNothing);
  });
}
