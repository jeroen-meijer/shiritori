import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shiritori/backend/backend.dart';
import 'package:shiritori/intl/intl.dart';
import 'package:shiritori/ui/widgets/widgets.dart';

class SetupPage extends StatefulWidget {
  const SetupPage({
    Key key,
    @required this.onSubmit,
  }) : super(key: key);

  final ValueChanged<GameSettings> onSubmit;

  @override
  _SetupPageState createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  static const _aniamtionInitialDelay = Duration(milliseconds: 200);
  static const _animationDuration = Duration(milliseconds: 250);
  static const _animationGapDuration = Duration(milliseconds: 150);

  var _delayFactor = 0;
  var _gameModeIsSingleplayer = true;
  var _languageIsJapanese = true;

  Duration get _animationDelay {
    return _aniamtionInitialDelay + (_animationGapDuration * _delayFactor++);
  }

  bool get _hasValidConfig => _gameModeIsSingleplayer && _languageIsJapanese;

  void _onToggleGameMode() {
    setState(() {
      _gameModeIsSingleplayer = !_gameModeIsSingleplayer;
    });
  }

  void _onToggleLanguage() {
    setState(() {
      _languageIsJapanese = !_languageIsJapanese;
    });
  }

  void _onSubmit() {
    widget.onSubmit(
      GameSettings.defaultFor(
        dictionary: Dictionaries.of(context, listen: false).japanese,
        enemyType: GameEnemyType.singleplayer,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final intl = ShiritoriLocalizations.of(context).game;

    return AppScaffold(
      title: Text(intl.newGame),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FadeInLeft(
                    delay: _animationDelay,
                    duration: _animationDuration,
                    child: ToggleCardButton(
                      value: _gameModeIsSingleplayer,
                      onTap: _onToggleGameMode,
                      child: Text(
                        _gameModeIsSingleplayer
                            ? intl.singleplayerTitle
                            // TODO: intl
                            : '${intl.multiplayerTitle} (not supported)',
                        key: Key(
                          'gameScreen_setupPage_singleplayerToggle_'
                          'singleplayerSelected_$_gameModeIsSingleplayer',
                        ),
                      ),
                    ),
                  ),
                  verticalMargin16,
                  FadeInLeft(
                    delay: _animationDelay,
                    duration: _animationDuration,
                    child: ToggleCardButton(
                      value: _languageIsJapanese,
                      onTap: _onToggleLanguage,
                      child: Text(
                        _languageIsJapanese
                            ? Language.japanese.name
                            // TODO: intl
                            : 'English (not supported)',
                        key: Key(
                          'gameScreen_setupPage_languageToggle_'
                          'japaneseSelected_$_languageIsJapanese',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Center(
            child: SizedBox(
              height: 64.0,
              child: _hasValidConfig
                  ? null
                  // TODO: intl
                  : const Text(
                      'Currently, only singleplayer and \n'
                      'the Japanese language are supported.',
                      textAlign: TextAlign.center,
                    ),
            ),
          ),
          FadeInUp(
            delay: _animationDelay,
            duration: _animationDuration,
            child: WideButton(
              onTap: !_hasValidConfig ? null : _onSubmit,
              child: Text(intl.start),
            ),
          ),
        ],
      ),
    );
  }
}
