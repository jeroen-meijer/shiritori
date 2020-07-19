import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shiritori/ui/main/home/widgets/widgets.dart';
import 'package:shiritori/ui/routes/zoom_page_route.dart';
import 'package:shiritori/ui/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  Widget _buildRouteButton(BuildContext context) {
    return CupertinoButton.filled(
      onPressed: () {
        Navigator.of(context).push(
          ZoomPageRoute(
            builder: (context) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CupertinoButton.filled(
                    onPressed: Navigator.of(context).pop,
                    child: const Text('[DEBUG] Route back'),
                  ),
                  verticalMargin12,
                  _buildRouteButton(context),
                ],
              );
            },
          ),
        );
      },
      child: const Text('[DEBUG] Route forward'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Column(
        children: [
          const Expanded(
            flex: 2,
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: HomeHeader(),
              ),
            ),
          ),
          const Expanded(
            flex: 3,
            child: HomeMenu(),
          ),
          _buildRouteButton(context),
        ],
      ),
    );
  }
}
