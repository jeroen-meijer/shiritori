import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shiritori/intl/intl.dart';
import 'package:shiritori/theme/theme.dart';
import 'package:shiritori/ui/main/quick_play/quick_play.dart';
import 'package:shiritori/ui/widgets/widgets.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final intl = ShiritoriLocalizations.of(context).home;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _PlayCard(
              title: Text(intl.quickPlayCardTitle),
              subtitle: Text(intl.quickPlayCardSubtitle),
              color: AppTheme.orange,
              icon: const Text('遊ぶ'),
              expandedChildBuilder: (context) {
                return QuickPlayScreen();
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
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
      ],
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

    return Opacity(
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
          return ScaleButton.builder(
            onTap: !enabled ? null : open,
            builder: (context, scale) {
              return Material(
                type: MaterialType.transparency,
                child: DefaultStylingColor(
                  color: color,
                  child: SizedBox.fromSize(
                    size: const Size.square(164.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          DefaultTextStyle.merge(
                            style: textTheme.subtitle2,
                            child: subtitle,
                          ),
                          const _SubtitleLine(),
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
          );
        },
      ),
    );
  }
}

class _SubtitleLine extends StatelessWidget {
  const _SubtitleLine({
    Key key,
    this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36.0,
      child: Divider(
        color: color,
      ),
    );
  }
}
