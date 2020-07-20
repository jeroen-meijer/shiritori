import 'package:flutter/material.dart';
import 'package:shiritori/intl/intl.dart';
import 'package:shiritori/theme/theme.dart';
import 'package:shiritori/ui/widgets/widgets.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final intl = ShiritoriLocalizations.of(context).home;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(),
        Expanded(
          flex: 2,
          child: Center(
            child: SizedBox(
              width: double.infinity,
              child: Text(
                intl.welcomeHeader('Jeroen'),
                style: textTheme.headline3.copyWith(
                  color: AppTheme.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _Statistic(
                title: intl.guessesStatisticTitle,
                value: '569',
              ),
              _Statistic(
                title: intl.pointsStatisticTitle,
                value: '3 980',
              ),
              _Statistic(
                title: intl.rankStatisticTitle,
                value: '420',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Statistic extends StatelessWidget {
  const _Statistic({
    Key key,
    @required this.title,
    @required this.value,
  }) : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: textTheme.subtitle2.copyWith(
            color: AppTheme.yellow,
          ),
        ),
        verticalMargin4,
        Text(
          value,
          style: textTheme.headline4.copyWith(
            color: AppTheme.white,
          ),
        ),
      ],
    );
  }
}
