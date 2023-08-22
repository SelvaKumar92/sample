import 'package:flutter_test/flutter_test.dart';
import 'package:plateron/presentation/presentation.dart';
import 'package:plateron/presentation/widgets/button/cart_button.dart';

Widget _wrapWithMaterialApp(Widget widget) => MaterialApp(home: Scaffold(body: widget));

Future<void> main() async {
  testWidgets('widget is shown', (WidgetTester tester) async {
    // arrange
    final widget = CartButton(
      quantity: 0,
    );
    // act
    await tester.pumpWidget(_wrapWithMaterialApp(widget));
    final widgetFinder = find.byType(CartButton);
    // assert
    expect(widgetFinder, findsOneWidget);
  });
  testWidgets('add button is shown', (WidgetTester tester) async {
    // arrange
    final widget = CartButton(
      quantity: 0,
    );
    // act
    await tester.pumpWidget(_wrapWithMaterialApp(widget));
    final textFinder = find.text('Add');
    // expect
    expect(textFinder, findsOneWidget);
  });
  testWidgets('quantity is shown', (WidgetTester tester) async {
    // arrange
    final widget = CartButton(
      quantity: 1,
    );
    // act
    await tester.pumpWidget(_wrapWithMaterialApp(widget));
    final textFinder = find.text(' 1 ');
    // expect
    expect(textFinder, findsOneWidget);
  });
  testWidgets('quantity is shown', (WidgetTester tester) async {
    // arrange
    final widget = CartButton(
      quantity: 12,
    );
    // act
    await tester.pumpWidget(_wrapWithMaterialApp(widget));
    final textFinder = find.text(' 12 ');
    // expect
    expect(textFinder, findsOneWidget);
  });
  testWidgets('Add icon shown', (WidgetTester tester) async {
    // arrange
    final widget = CartButton(
      quantity: 34,
    );
    // act
    await tester.pumpWidget(_wrapWithMaterialApp(widget));
    final add = tester.widget<Icon>(find.byKey(Key('add')));

    // expect
    expect(add.icon, Icons.add);
  });
  testWidgets('Remove icon shown', (WidgetTester tester) async {
    // arrange
    final widget = CartButton(
      quantity: 34,
    );
    // act
    await tester.pumpWidget(_wrapWithMaterialApp(widget));
    final add = tester.widget<Icon>(find.byKey(Key('remove')));

    // expect
    expect(add.icon, Icons.remove);
  });
}
