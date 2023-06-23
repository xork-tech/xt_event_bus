`xt_event_bus` is a powerful library that simplifies event-driven communication within your Flutter applications. Based on the popular EventBus pattern, this library provides a streamlined solution for efficiently exchanging messages, notifications, and data between different components of your app. With `xt_event_bus`, you can easily decouple and organize your code, enabling better separation of concerns and promoting cleaner and more maintainable architectures. By employing a publish-subscribe model, this library allows you to create dynamic and flexible communication channels that connect different parts of your application effortlessly.

## Installation

```console
$ dart pub add xt_event_bus
```

## Usage

If you want to listen to a specific event, we recommend using the `EventHandler<T>` mixin.
To receive events, you need to invoke the `subscribe` method.
To release resources, you should invoke the `unsubscribe` method.
To handle event, you should to override `onEvent` method.

For example, we have event `MyEvent`.

```dart
class MyEvent {}
```

For listening this event with using mixin `EventHandler<MyEvent>`.

```dart
class MyWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyWidgetState();
}

class MyWidgetState extends State<MyWidget> with EventHandler<MyEvent> {
  @override
  void initState() {
    super.initState();
    subscribe();
  }

  @override
  void dispose() {
    unsubscribe();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  @override
  void onEvent(MyEvent event) {
    //some actions
  }
}
```

For emit event we recommend using the `EventEmiiter<T>` mixin, you should invoke method `emit` then all subscribers with type `T` recieve this event.

```dart
class OtherScreenWidget extends StatelessWidget with EventEmitter<MyEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            emit(MyEvent());
          },
          child: Text('Send event'),
        ),
      ),
    );
  }
}
```

If you woud like to listen event without mixin's, you can use method `on<T>` of `EventBus` class.
Method `on<T>` returning `Stream` and you need make listen and handle stream subscription manually.

For example:

```dart
class MyWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyWidgetState();
}

class MyWidgetState extends State<MyWidget> {
  StreamSubscription<MyEvent>? subscription;

  @override
  void initState() {
    super.initState();
    subscription = EventBus().on<MyEvent>().listen((event) {
      //some actions
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
```

For emit event without mixin you should invoke `emit<T>` method of `EventBus` class.

For example:

```dart
EventBus().emit<MyEvent>(MyEvent());
```

## Logging

For logging you can implements `EventBusLog` interface and set your log implementation in `EventBus`.

For example:

```dart
class MyEventBysLog implements EventBusLog {
  @override
  void onEmit(event) {
    print('On emit: $event');
  }

  @override
  void onEvent(event) {
    print('On received: $event');
  }

  @override
  void onSubscribe(Type type) {
    print('On subscribe: $type');
  }
}

void main() {
    EventBus().log = MyEventBysLog();
}
```