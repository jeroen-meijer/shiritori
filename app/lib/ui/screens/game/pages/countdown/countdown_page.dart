import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:shiritori/backend/backend.dart';
import 'package:shiritori/intl/intl.dart';
import 'package:shiritori/theme/theme.dart';
import 'package:shiritori/ui/widgets/widgets.dart';

class CountdownPage extends StatelessWidget {
  const CountdownPage({
    Key key,
    @required this.secondsRemaining,
  })  : assert(secondsRemaining != null),
        super(key: key);

  final int secondsRemaining;

  Color get _countdownGlowColor {
    if (secondsRemaining == 1) {
      return AppTheme.green;
    } else if (secondsRemaining == 2) {
      return AppTheme.lightBlue;
    } else {
      return AppTheme.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final intl = ShiritoriLocalizations.of(context).game;
    final textTheme = Theme.of(context).textTheme;
    final game = Game.of(context);

    return Scaffold(
      body: Column(
        children: [
          topSafePadding,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  game.settings.enemyType.isSingleplayer
                      ? intl.singleplayerTitle
                      : intl.multiplayerTitle,
                  style: textTheme.headline3,
                ),
                Text(
                  game.settings.dictionary.language.name,
                  style: textTheme.headline4,
                ),
              ],
            ),
          ),
          Text(
            intl.getReady,
            style: textTheme.headline5.copyWith(color: AppTheme.grey),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: AvatarGlow(
                endRadius: 100,
                duration: const Duration(seconds: 1),
                repeatPauseDuration: Duration.zero,
                glowColor: _countdownGlowColor,
                child: Material(
                  elevation: AppTheme.elevationDisabled,
                  animationDuration: const Duration(milliseconds: 150),
                  shape: const CircleBorder(),
                  child: SizedBox.fromSize(
                    size: const Size.square(100.0),
                    child: Center(
                      child: Text(
                        '$secondsRemaining',
                        style: textTheme.headline3,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
