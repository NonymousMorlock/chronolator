import 'package:chronolator/src/app/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      expect(const App(), isNotNull);
    });
  });
}
