import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shiritori/backend/backend.dart';
import 'package:shiritori/intl/intl.dart';
import 'package:shiritori/theme/theme.dart';
import 'package:shiritori/ui/screens/game/game.dart';
import 'package:shiritori/ui/screens/home/widgets/widgets.dart';
import 'package:shiritori/ui/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backgroundImage = Provider.of<ui.Image>(context, listen: false);
    final intl = ShiritoriLocalizations.of(context).home;

    return Scaffold(
      body: DefaultStylingColor(
        color: AppTheme.blue,
        child: Stack(
          children: [
            Positioned.fill(
              child: AnimatedZoomContainer(
                scale: 0.6,
                child: RawImage(
                  image: backgroundImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned.fill(
              child: AnimatedZoomContainer(
                scale: 1.3,
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.all(24.0),
                          child: HomeHeader(),
                        ),
                      ),
                      const Expanded(
                        flex: 3,
                        child: HomeMenu(),
                      ),
                      ExpandingRouteButton(
                        routeBuilder: (context) {
                          return const GameScreen(
                            useDefaultSettings: true,
                            enemyType: GameEnemyType.singleplayer,
                          );
                        },
                        child: Text(intl.quickPlayButtonTitle),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A proxy animation that passes on its parent animation's value unless that
/// value is 1.0, in which case it returns 0.0.
///
/// The reason for this animation's logic is because of a bug in the
/// `animations` package's `OpenContainer` widget.
///
/// If an `OpenContainer` is being closed while it's context is changing size
/// (for example, using an `AnimatedBuilder` that `Transform.scale`s its
/// child), the `OpenContainer` will animate to the wrong place and then pop
/// back into place once the animation is done. Setting the value corresponding
/// to `1.0` to `0.0` fixes this.
class BugfixAnimation extends Animation<double>
    with
        AnimationLazyListenerMixin,
        AnimationLocalListenersMixin,
        AnimationLocalStatusListenersMixin {
  BugfixAnimation(this._parent);

  final Animation<double> _parent;

  @override
  void didStartListening() {
    if (_parent != null) {
      _parent.addListener(notifyListeners);
      _parent.addStatusListener(notifyStatusListeners);
    }
  }

  @override
  void didStopListening() {
    if (_parent != null) {
      _parent.removeListener(notifyListeners);
      _parent.removeStatusListener(notifyStatusListeners);
    }
  }

  @override
  AnimationStatus get status => _parent.status;

  @override
  double get value => _parent.value == 1.0 ? 0.0 : _parent.value;

  @override
  String toString() => _parent.toString();
}
