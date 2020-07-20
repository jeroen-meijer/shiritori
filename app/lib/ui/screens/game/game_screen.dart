import 'dart:async';

import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shiritori/backend/backend.dart';
import 'package:shiritori/ui/screens/game/pages/pages.dart';

/// TEMPORARILY A SEARCH SCREEN FOR DICTIONARIES
class GameScreen extends StatefulWidget {
  GameScreen({
    Key key,
    @required this.game,
  })  : assert(game != null),
        super(key: key);

  final Game game;

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  static const _playCountdownSeconds = 3;

  Timer _playCountdownTimer;

  @override
  void initState() {
    super.initState();

    // Delaying the timer to sync up better with the surrounding animation.
    Future.delayed(const Duration(milliseconds: 300), () {
      _playCountdownTimer = Timer.periodic(
        const Duration(seconds: 1),
        (_) => _onPlayCountdownTimerTick(),
      );
    });
  }

  @override
  void dispose() {
    _playCountdownTimer?.cancel();
    super.dispose();
  }

  void _onPlayCountdownTimerTick() {
    setState(() {});
    if (_playCountdownTimer.tick == _playCountdownSeconds) {
      _playCountdownTimer.cancel();
    }
  }

  int get _playCountdownSecondsRemaining {
    return _playCountdownSeconds - (_playCountdownTimer?.tick ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return Provider<Game>.value(
      value: widget.game,
      child: PageTransitionSwitcher(
        transitionBuilder: (child, animation, secondaryAnimation) {
          return SharedAxisTransition(
            transitionType: SharedAxisTransitionType.vertical,
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: _playCountdownSecondsRemaining > 0
            ? CountdownPage(
                secondsRemaining: _playCountdownSecondsRemaining,
              )
            : const InGamePage(),
      ),
    );
  }
}
