import 'package:first_app_a/screens/widgets/make_rs_text.dart';
import 'package:first_app_a/screens/widgets/textbox_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {

  testWidgets("Testing text widget", (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: MakeRsText( price: '100',),
        )
      )
    );
    final textFinder = find.text("100");
    expect(textFinder, findsOneWidget);
  });


  testWidgets("Test input widget", (tester) async{
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: TextboxWidget(),
        )
      ));
    await tester.enterText(find.byType(TextFormField), "Hello");
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    final textFinder = find.text("Hello");
    expect(textFinder, findsWidgets);
  });
}