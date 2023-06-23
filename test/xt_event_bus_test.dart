import 'package:flutter_test/flutter_test.dart';
import 'package:xt_event_bus/src/event_bus.dart';
import 'package:xt_event_bus/src/event_handler.dart';

import 'package:xt_event_bus/xt_event_bus.dart';

abstract class Test {}

class ATest extends Test {}

class BTest extends Test {}

void main() {
  group('EventBus', () {
    test('test typing', () {
      expect(EventBus().on<ATest>(), emitsInOrder([isA<ATest>(), emitsDone]));

      expect(EventBus().on<BTest>(), emitsInOrder([isA<BTest>(), emitsDone]));

      expect(
        EventBus().on<Test>(),
        emitsInOrder(
          [
            isA<ATest>(),
            isA<BTest>(),
            emitsDone,
          ],
        ),
      );

      EventBus().emit(ATest());
      EventBus().emit(BTest());

      EventBus().dispose();
    });
  });
}
