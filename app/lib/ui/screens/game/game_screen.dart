import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shiritori/assets/assets.dart';
import 'package:shiritori/intl/intl.dart';
import 'package:shiritori/theme/theme.dart';
import 'package:shiritori/ui/widgets/widgets.dart';

class GameScreen extends StatefulWidget {
  GameScreen({
    Key key,
    @required this.dictionary,
  })  : assert(dictionary != null),
        super(key: key);

  final Dictionary dictionary;

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  static const _query = 'しお';

  List<WordEntry> _searchResults;

  @override
  void initState() {
    super.initState();
    _searchResults = widget.dictionary.searchWord(_query);
  }

  @override
  Widget build(BuildContext context) {
    final intl = ShiritoriLocalizations.of(context).game;
    final uiIntl = ShiritoriLocalizations.of(context).ui;

    return Provider<Dictionary>.value(
      value: widget.dictionary,
      child: DefaultStylingColor(
        color: AppTheme.colorSingleplayer,
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              AppSliverNavigationBar(
                title: Text(intl.singleplayerTitle),
                leading: TextButton(
                  onTap: Navigator.of(context).pop,
                  child: Text(uiIntl.back),
                ),
              ),
              SliverFillRemaining(
                child: Center(
                  child: Text(
                    'Selected dictionary: ${widget.dictionary}\n'
                    'Information for the word $_query:\n'
                    '$_searchResults',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
