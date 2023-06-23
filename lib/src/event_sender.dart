import 'package:flutter/foundation.dart';

import '../xt_event_bus.dart';

mixin EventEmitter<T> {
  @protected
  void emit(T event) {
    EventBus().emit(event);
  }
}
