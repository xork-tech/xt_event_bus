abstract interface class EventBusLog {
  void onEmit(dynamic event);
  void onSubscribe(Type type);
  void onEvent(dynamic event);
}
