import 'package:flutter/widgets.dart';

class RouteNotifier<R extends ModalRoute> extends NavigatorObserver {
  final _listeners = <RouteNotifierListener>[];

  @override
  void didPop(Route route, Route previousRoute) {
    if (route is R || previousRoute is R) {
      for (final listener in _listeners) {
        listener.didPop?.call(route, previousRoute);
      }
    }
  }

  @override
  void didPush(Route route, Route previousRoute) {
    if (route is R || previousRoute is R) {
      for (final listener in _listeners) {
        listener.didPush?.call(route, previousRoute);
      }
    }
  }

  @override
  void didRemove(Route route, Route previousRoute) {
    if (route is R || previousRoute is R) {
      for (final listener in _listeners) {
        listener.didRemove?.call(route, previousRoute);
      }
    }
  }

  @override
  void didReplace({Route newRoute, Route oldRoute}) {
    if (newRoute is R || oldRoute is R) {
      for (final listener in _listeners) {
        listener.didReplace?.call(newRoute: newRoute, oldRoute: oldRoute);
      }
    }
  }
}

mixin RouteNotifierStateMixin<R extends ModalRoute, T extends StatefulWidget>
    on State<T> {
  RouteNotifierListener<R> _listener;

  RouteNotifier<R> get routeNotifier;

  @override
  void initState() {
    super.initState();

    _listener = RouteNotifierListener<R>(
      didPop: didPop,
      didPush: didPush,
      didRemove: didRemove,
      didReplace: didReplace,
    );
    routeNotifier._listeners.add(_listener);
  }

  @override
  void dispose() {
    if (_listener != null) {
      routeNotifier._listeners.remove(_listener);
    }
    super.dispose();
  }

  void didPop(Route route, Route previousRoute);
  void didPush(Route route, Route previousRoute);
  void didRemove(Route route, Route previousRoute);
  void didReplace({Route newRoute, Route oldRoute});
}

@immutable
class RouteNotifierListener<R extends ModalRoute> {
  const RouteNotifierListener({
    this.didPop,
    this.didPush,
    this.didRemove,
    this.didReplace,
  });

  final void Function(Route route, Route previousRoute) didPop;
  final void Function(Route route, Route previousRoute) didPush;
  final void Function(Route route, Route previousRoute) didRemove;
  final void Function({Route newRoute, Route oldRoute}) didReplace;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is RouteNotifierListener<R> &&
        other.didPop == didPop &&
        other.didPush == didPush &&
        other.didRemove == didRemove &&
        other.didReplace == didReplace;
  }

  @override
  int get hashCode =>
      didPop.hashCode ^
      didPush.hashCode ^
      didRemove.hashCode & didReplace.hashCode;
}
