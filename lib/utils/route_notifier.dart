import 'package:flutter/widgets.dart';

class RouteNotifier<R extends ModalRoute> extends NavigatorObserver {
  void Function(Route route, Route previousRoute) _didPop;
  void Function(Route route, Route previousRoute) _didPush;
  void Function(Route route, Route previousRoute) _didRemove;
  void Function({Route newRoute, Route oldRoute}) _didReplace;

  @override
  void didPop(Route route, Route previousRoute) {
    if (route is R || previousRoute is R) {
      _didPop?.call(route, previousRoute);
    }
  }

  @override
  void didPush(Route route, Route previousRoute) {
    if (route is R || previousRoute is R) {
      _didPush?.call(route, previousRoute);
    }
  }

  @override
  void didRemove(Route route, Route previousRoute) {
    if (route is R || previousRoute is R) {
      _didRemove?.call(route, previousRoute);
    }
  }

  @override
  void didReplace({Route newRoute, Route oldRoute}) {
    if (newRoute is R || oldRoute is R) {
      _didReplace?.call(newRoute: newRoute, oldRoute: oldRoute);
    }
  }
}

mixin RouteNotifierStateMixin<R extends ModalRoute, T extends StatefulWidget>
    on State<T> {
  RouteNotifier<R> get routeNotifier;

  @override
  void initState() {
    super.initState();

    routeNotifier._didPop = didPop;
    routeNotifier._didPush = didPush;
    routeNotifier._didRemove = didRemove;
    routeNotifier._didReplace = didReplace;
  }

  void didPop(Route route, Route previousRoute);
  void didPush(Route route, Route previousRoute);
  void didRemove(Route route, Route previousRoute);
  void didReplace({Route newRoute, Route oldRoute});
}
