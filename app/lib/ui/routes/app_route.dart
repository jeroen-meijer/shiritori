import 'package:flutter/material.dart';

class AppRoute<T> extends PageRoute<T> with MaterialRouteTransitionMixin<T> {
  AppRoute({
    @required this.builder,
    RouteSettings settings,
    this.maintainState = true,
    bool fullscreenDialog = false,
  })  : assert(builder != null),
        assert(maintainState != null),
        assert(fullscreenDialog != null),
        assert(opaque),
        super(
          settings: settings,
          fullscreenDialog: fullscreenDialog,
        );

  @override
  bool canTransitionFrom(TransitionRoute previousRoute) => true;

  @override
  bool canTransitionTo(TransitionRoute nextRoute) => true;

  @override
  final WidgetBuilder builder;

  @override
  final bool maintainState;
}
