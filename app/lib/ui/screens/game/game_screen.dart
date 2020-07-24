import 'dart:async';

import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shiritori/ui/screens/game/pages/pages.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key key}) : super(key: key);

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
    return PageTransitionSwitcher(
      transitionBuilder: (child, animation, secondaryAnimation) {
        return SharedAxisTransition(
          transitionType: SharedAxisTransitionType.vertical,
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        );
      },
      child: _playCountdownSecondsRemaining > 0
          ? Provider.value(
              value: _playCountdownSecondsRemaining,
              child: const CountdownPage(),
            )
          : const InGamePage(),
    );
  }
}
