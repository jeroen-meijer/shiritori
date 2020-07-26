import 'dart:async';

import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shiritori/backend/backend.dart';
import 'package:shiritori/ui/screens/game/pages/pages.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({
    Key key,
    @required this.settings,
  })  : assert(settings != null),
        super(key: key);

  final GameSettings settings;

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  static const _playCountdownSeconds = 3;

  Game _game;

  int _secondsRemaining;
  Timer _playCountdownTimer;

  bool get _showInGame => _secondsRemaining == 0;

  @override
  void initState() {
    super.initState();
    _game = Game.startNew(widget.settings);
    _resetTimer();
  }

  @override
  void dispose() {
    _playCountdownTimer?.cancel();
    super.dispose();
  }

  void _resetTimer() {
    _secondsRemaining = _playCountdownSeconds;
    // Delaying the timer to sync up better with the surrounding animation.
    Future.delayed(const Duration(milliseconds: 300), () {
      _playCountdownTimer = Timer.periodic(
        const Duration(seconds: 1),
        (_) => _onPlayCountdownTimerTick(),
      );
    });
  }

  void _onPlayCountdownTimerTick() {
    setState(() {
      _secondsRemaining = _playCountdownSeconds - _playCountdownTimer.tick;
      if (_playCountdownTimer.tick == _playCountdownSeconds) {
        _playCountdownTimer.cancel();
      }
    });
  }

  void _onRestart() {
    _game = Game.startNew(widget.settings);
    setState(_resetTimer);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _game,
      child: PageTransitionSwitcher(
        transitionBuilder: (child, animation, secondaryAnimation) {
          return SharedAxisTransition(
            transitionType: SharedAxisTransitionType.vertical,
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: !_showInGame
            ? Provider.value(
                value: _secondsRemaining,
                child: const CountdownPage(),
              )
            : InGamePage(
                onRestart: _onRestart,
              ),
      ),
    );
  }
}
