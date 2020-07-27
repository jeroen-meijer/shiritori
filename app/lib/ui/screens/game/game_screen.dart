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
    this.useDefaultSettings = false,
    @required this.enemyType,
  })  : assert(useDefaultSettings != null),
        assert(enemyType != null),
        super(key: key);

  final bool useDefaultSettings;
  final GameEnemyType enemyType;

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  static const _playCountdownSeconds = 3;

  Game _game;

  int _secondsRemaining;
  Timer _playCountdownTimer;

  GameSettings _settings;

  bool get _isQuickPlay => widget.useDefaultSettings;
  bool get _showSetup => _settings == null;
  bool get _showInGame => !_showSetup && _secondsRemaining == 0;

  @override
  void initState() {
    super.initState();

    if (_isQuickPlay) {
      _setGameWithDefaultSettings();
      _resetTimer();
    }
  }

  @override
  void dispose() {
    _playCountdownTimer?.cancel();
    super.dispose();
  }

  void _setGameWithDefaultSettings() {
    _settings = GameSettings.defaultFor(
      enemyType: widget.enemyType,
      dictionary: Dictionaries.of(context, listen: false).japanese,
    );
    _game = Game.startNew(_settings);
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

  void _onSubmitSettings(GameSettings settings) {
    _settings = settings;
    _game = Game.startNew(_settings);
    setState(_resetTimer);
  }

  void _onRestart() {
    _game = Game.startNew(_settings);
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
        child: _showSetup
            ? SetupPage(
                onSubmit: _onSubmitSettings,
              )
            : !_showInGame
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
