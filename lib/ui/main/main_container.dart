import 'package:flutter/material.dart';
import 'package:shiritori/ui/main/main.dart';
import 'package:shiritori/ui/main/widgets/widgets.dart';
import 'package:shiritori/ui/routes/routes.dart';
import 'package:shiritori/utils/utils.dart';

class MainContainer extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();
  final _routeNotifier = RouteNotifier<ZoomPageRoute>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Background(
            routeNotifier: _routeNotifier,
          ),
          SafeArea(
            child: WillPopScope(
              onWillPop: () async {
                return !await _navigatorKey.currentState?.maybePop();
              },
              child: Navigator(
                key: _navigatorKey,
                observers: [_routeNotifier],
                onGenerateRoute: (_) {
                  return ZoomPageRoute(
                    builder: (_) => const HomeScreen(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
