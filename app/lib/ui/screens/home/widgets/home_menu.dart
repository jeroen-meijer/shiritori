import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shiritori/backend/backend.dart';
import 'package:shiritori/intl/intl.dart';
import 'package:shiritori/theme/theme.dart';
import 'package:shiritori/ui/screens/game/game.dart';
import 'package:shiritori/ui/widgets/widgets.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final intl = ShiritoriLocalizations.of(context).home;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _PlayCard(
                  title: Text(intl.singleplayerCardTitle),
                  subtitle: Text(intl.singleplayerCardSubtitle),
                  color: AppTheme.colorSingleplayer,
                  icon: const Text('遊ぶ'),
                  expandedChildBuilder: (context) {
                    return GameScreen(
                      settings: SingleplayerGameSettings(
                        dictionary: Dictionaries.of(context).japanese,
                        answeringDuration: const Duration(seconds: 10),
                      ),
                    );
                  },
                ),
                _PlayCard(
                  title: Text(intl.multiplayerCardTitle),
                  subtitle: Text(intl.multiplayerCardSubtitle),
                  color: AppTheme.lightBlue,
                  icon: const Icon(FontAwesomeIcons.globeAmericas),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _PlayCard(
                  title: Text(intl.statsCardTitle),
                  subtitle: Text(intl.statsCardSubtitle),
                  color: AppTheme.pink,
                  icon: const Icon(FontAwesomeIcons.signal),
                ),
                _PlayCard(
                  title: Text(intl.settingsCardTitle),
                  subtitle: Text(intl.settingsCardSubtitle),
                  color: AppTheme.grey,
                  icon: const Icon(FontAwesomeIcons.cog),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayCard extends StatelessWidget {
  const _PlayCard({
    Key key,
    @required this.title,
    @required this.subtitle,
    @required this.color,
    @required this.icon,
    this.expandedChildBuilder,
  }) : super(key: key);

  final Widget title;
  final Widget subtitle;
  final Color color;
  final Widget icon;
  final WidgetBuilder expandedChildBuilder;

  bool get enabled => expandedChildBuilder != null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardTheme = theme.cardTheme;
    final textTheme = theme.textTheme;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: AspectRatio(
          aspectRatio: 1,
          child: Opacity(
            opacity: expandedChildBuilder != null ? 1.0 : 0.5,
            child: OpenContainer(
              tappable: false,
              transitionDuration: AppTheme.durationAnimationDefault,
              openBuilder: (context, close) {
                return expandedChildBuilder?.call(context);
              },
              closedColor: cardTheme.color,
              closedShape: cardTheme.shape,
              closedElevation: cardTheme.elevation,
              closedBuilder: (context, open) {
                return ScaleButton(
                  onTap: !enabled ? null : open,
                  child: Material(
                    type: MaterialType.transparency,
                    child: DefaultStylingColor(
                      color: color,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            DefaultTextStyle.merge(
                              style: textTheme.caption,
                              child: subtitle,
                            ),
                            const SubtitleLine(),
                            verticalMargin4,
                            DefaultTextStyle.merge(
                              maxLines: 1,
                              softWrap: false,
                              overflow: TextOverflow.fade,
                              style: textTheme.headline5,
                              child: title,
                            ),
                            const Spacer(),
                            DefaultTextStyle.merge(
                              style: TextStyle(
                                fontWeight: textTheme.headline4.fontWeight,
                              ),
                              child: AbsoluteTextIconTheme(
                                size: 56.0,
                                color: color,
                                child: icon,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
