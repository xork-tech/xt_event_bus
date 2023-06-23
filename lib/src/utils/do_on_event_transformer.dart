import 'dart:async';

class DoOnEventTransformer<T> extends StreamTransformerBase<T, T> {
  final void Function(T) onEventCallback;

  DoOnEventTransformer(this.onEventCallback);

  @override
  Stream<T> bind(Stream<T> stream) {
    return stream.transform(StreamTransformer<T, T>.fromHandlers(
      handleData: (T event, EventSink<T> sink) {
        onEventCallback(event);
        sink.add(event);
      },
      handleError: (Object error, StackTrace stackTrace, EventSink<T> sink) {
        sink.addError(error, stackTrace);
      },
      handleDone: (EventSink<T> sink) {
        sink.close();
      },
    ));
  }
}

extension DoOnEventExtension<T> on Stream<T> {
  Stream<T> doOnEvent(void Function(T event) onEventCallback) {
    return transform(DoOnEventTransformer<T>(onEventCallback));
  }
}
