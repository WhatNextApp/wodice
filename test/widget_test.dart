import 'package:flutter_test/flutter_test.dart';
import 'package:wodice/main.dart' as wodice;

void main() {
  test('main test', () {
    // Call the main function
    wodice.main();

    // Since main() is usually void and doesn't return anything,
    // there isn't much we can test. We just ensure it completes without error.
    expect(true, true);
  });
}
