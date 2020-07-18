import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shiritori/intl/intl.dart';
import 'package:shiritori/theme/theme.dart';
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
              title: intl.quickPlayCardTitle,
              subtitle: intl.quickPlayCardSubtitle,
              color: AppTheme.orange,
              icon: const Text('遊ぶ'),
              onTap: () {},
            ),
            _PlayCard(
              title: intl.multiplayerCardTitle,
              subtitle: intl.multiplayerCardSubtitle,
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
              title: intl.statsCardTitle,
              subtitle: intl.statsCardSubtitle,
              color: AppTheme.pink,
              icon: const Icon(FontAwesomeIcons.signal),
              onTap: null,
            ),
            _PlayCard(
              title: intl.settingsCardTitle,
              subtitle: intl.settingsCardSubtitle,
              color: AppTheme.grey,
              icon: const Icon(FontAwesomeIcons.cog),
              onTap: () {},
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

  final String title;
  final String subtitle;
  final Color color;
  final Widget icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Opacity(
      opacity: onTap != null ? 1.0 : 0.5,
      child: ScaleButton(
        onTap: onTap,
        child: DefaultStylingColor(
          color: color,
          child: Card(
            child: SizedBox.fromSize(
              size: const Size.square(164.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      subtitle.toUpperCase(),
                      style: textTheme.subtitle2,
                    ),
                    const _SubtitleLine(),
                    verticalMargin4,
                    Text(
                      title,
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                      style: textTheme.headline5,
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
        ),
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
