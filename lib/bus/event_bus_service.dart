import 'event_bus.dart';

typedef void EventCallback(arg);

/// 消息结构体
class EventMessage {

  final String eventName;

  final dynamic arguments;

  EventMessage(this.eventName, {this.arguments});

}

/// 消息通知服务
class EventBusService{
  static EventBusService? _single;
  EventBusService._();

  static EventBusService getInstance(){
    return _single ??= EventBusService._();
  }

  EventBus _eBus = EventBus();
  EventBus get eventBus {
    return _eBus;
  }
}


