import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:xt_event_bus/src/event_bus.dart';

mixin EventHandler<T> {
  StreamSubscription<T>? _subscription;

  void subscribe() {
    _subscription = EventBus().on<T>().listen(onEvent);
  }

  void unsubscribe() {
    _subscription?.cancel();
  }

  @protected
  void onEvent(T event);
}
