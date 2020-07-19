import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shiritori/intl/intl.dart';
import 'package:shiritori/theme/theme.dart';
import 'package:shiritori/ui/main/quick_play/quick_play.dart';
import 'package:shiritori/ui/routes/routes.dart';
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
              onTap: (context) {
                Navigator.of(context).push(
                  RoundedClipRoute(
                    builder: (context) => QuickPlayScreen(),
                    expandFrom: context,
                    border: null,
                    transitionDuration: AppTheme.durationAnimationDefault * 1.5,
                  ),
                );
              },
            ),
            _PlayCard(
              title: Text(intl.multiplayerCardTitle),
              subtitle: Text(intl.multiplayerCardSubtitle),
              color: AppTheme.lightBlue,
              icon: const Icon(FontAwesomeIcons.globeAmericas),
              onTap: null,
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
              onTap: null,
            ),
            _PlayCard(
              title: Text(intl.settingsCardTitle),
              subtitle: Text(intl.settingsCardSubtitle),
              color: AppTheme.grey,
              icon: const Icon(FontAwesomeIcons.cog),
              onTap: (context) {},
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
    @required this.onTap,
  }) : super(key: key);

  final Widget title;
  final Widget subtitle;
  final Color color;
  final Widget icon;
  final ValueChanged<BuildContext> onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardTheme = theme.cardTheme;
    final textTheme = theme.textTheme;

    return Opacity(
      opacity: onTap != null ? 1.0 : 0.5,
      child: ScaleButton.builder(
        onTap: onTap == null ? null : () => onTap(context),
        builder: (context, scale) {
          final elevationFactor = (scale - ScaleButton.defaultTappedScale) *
              (1 / (1 - ScaleButton.defaultTappedScale));

          final elevation = (cardTheme.elevation * (elevationFactor * 0.8)) +
              (cardTheme.elevation * 0.2);

          return DefaultStylingColor(
            color: color,
            child: RawCard(
              elevation: elevation,
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
