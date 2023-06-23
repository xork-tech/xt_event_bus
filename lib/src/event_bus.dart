import 'dart:async';

import 'package:xt_event_bus/src/utils/do_on_event_transformer.dart';

import 'event_bus_log.dart';

class EventBus {
  static final EventBus _instance = EventBus._internal();
  EventBusLog? _log;
  set log(EventBusLog? log) => _log = log;

  factory EventBus() => _instance;

  final StreamController<dynamic> _controller =
      StreamController<dynamic>.broadcast();

  EventBus._internal();

  void emit<T>(T event) {
    _log?.onEmit(event);
    _controller.add(event);
  }

  Stream<T> on<T>() {
    _log?.onSubscribe(T);
    return _controller.stream
        .doOnEvent((event) {
          _log?.onEvent(event);
        })
        .where((event) => event is T)
        .cast<T>();
  }

  void dispose() {
    _controller.close();
  }
}
