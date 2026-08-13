import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/main.dart';

void main() {
  testWidgets('MyApp shows the app title', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Weather App'), findsOneWidget);
  });
}
