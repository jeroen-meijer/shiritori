import 'package:flutter/material.dart';
import 'package:shiritori/ui/main/main.dart';
import 'package:shiritori/ui/main/widgets/widgets.dart';
import 'package:shiritori/ui/routes/routes.dart';

class MainContainer extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Background(
            navigatorKey: _navigatorKey,
          ),
          SafeArea(
            child: WillPopScope(
              onWillPop: () async {
                return !await _navigatorKey.currentState?.maybePop();
              },
              child: Navigator(
                key: _navigatorKey,
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
