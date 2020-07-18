import 'package:flutter/material.dart';
import 'package:shiritori/assets/assets.dart';

class Background extends StatefulWidget {
  const Background({
    Key key,
    @required this.navigatorKey,
  })  : assert(navigatorKey != null),
        super(key: key);

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  _BackgroundState createState() => _BackgroundState();
}

class _BackgroundState extends State<Background>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  Navigator get navigator => widget.navigatorKey.currentWidget as Navigator;

  @override
  void initState() {
    super.initState();
    initAnimations();
    initNavigatorObserver();
  }

  void initAnimations() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
  }

  void initNavigatorObserver() {
    // Pass RouteObserver through provider and fetch here?
  }

  @override
  Widget build(BuildContext context) {
    return Images.backgroundMain(
      fit: BoxFit.cover,
    );
  }
}
