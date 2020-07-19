import 'package:flutter/material.dart';

class AppRoute<T> extends MaterialPageRoute<T> {
  AppRoute({
    @required WidgetBuilder builder,
    RouteSettings settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
          builder: builder,
          settings: settings,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
        );

  @override
  bool canTransitionFrom(TransitionRoute previousRoute) => true;

  @override
  bool canTransitionTo(TransitionRoute nextRoute) => true;
}
