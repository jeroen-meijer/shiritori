import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shiritori/ui/main/main.dart';
import 'package:shiritori/ui/main/widgets/widgets.dart';
import 'package:shiritori/ui/routes/routes.dart';
import 'package:shiritori/utils/utils.dart';

class MainContainer extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();
  final _routeNotifier = RouteNotifier<ZoomPageRoute>();

  @override
  Widget build(BuildContext context) {
    final backgroundImage = Provider.of<ui.Image>(context, listen: false);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          ZoomContainer(
            key: const Key('mainContainer_zoomContainer_background'),
            routeNotifier: _routeNotifier,
            scaleFactor: 0.7,
            child: RawImage(
              image: backgroundImage,
              fit: BoxFit.cover,
            ),
          ),
          WillPopScope(
            onWillPop: () async {
              return !await _navigatorKey.currentState?.maybePop();
            },
            child: Navigator(
              key: _navigatorKey,
              observers: [
                _routeNotifier,
                HeroController(),
              ],
              onGenerateRoute: (_) {
                return ZoomPageRoute(
                  builder: (_) {
                    return ZoomContainer(
                      key: const Key('mainContainer_zoomContainer_homeScreen'),
                      routeNotifier: _routeNotifier,
                      scaleFactor: 1.0,
                      child: const HomeScreen(),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
