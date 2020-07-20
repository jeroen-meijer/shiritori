import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shiritori/assets/assets.dart';
import 'package:shiritori/intl/intl.dart';
import 'package:shiritori/theme/theme.dart';
import 'package:shiritori/ui/widgets/widgets.dart';

/// TEMPORARILY A SEARCH SCREEN FOR DICTIONARIES
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
  var _searchResults = <WordEntry>{};

  @override
  void initState() {
    super.initState();
  }

  void onChangeQuery(String query) {
    setState(() {
      _searchResults = widget.dictionary.searchWord(query);
    });
  }

  String get _formattedSearchResult {
    if (_searchResults.isEmpty) {
      'No word found...';
    }

    final sb = StringBuffer();

    sb.writeln('${_searchResults.length} words found!\n');

    for (final word in _searchResults) {
      sb.writeln('${[...word.spellings, word.phoneticSpellings].join(', ')}');
      for (final definition in word.definitions) {
        sb.writeln(' - $definition');
      }
      sb.writeln();
    }

    return sb.toString();
  }

  @override
  Widget build(BuildContext context) {
    // final intl = ShiritoriLocalizations.of(context).game;
    final uiIntl = ShiritoriLocalizations.of(context).ui;

    return Provider<Dictionary>.value(
      value: widget.dictionary,
      child: DefaultStylingColor(
        color: AppTheme.colorSingleplayer,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          resizeToAvoidBottomPadding: true,
          body: CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              AppSliverNavigationBar(
                // title: Text(intl.singleplayerTitle),
                title: const Text('Dictionary Test'),
                leading: TextButton(
                  onTap: Navigator.of(context).pop,
                  child: Text(uiIntl.back),
                ),
              ),
              SliverFillRemaining(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Text(_formattedSearchResult),
                      ),
                      verticalMargin12,
                      SizedBox(
                        width: double.infinity,
                        child: TextField(
                          autocorrect: false,
                          minLines: 1,
                          maxLines: 1,
                          decoration: InputDecoration(
                            errorText: _searchResults.isNotEmpty
                                ? null
                                : 'No word found.',
                            labelText: 'Word Query',
                            hintText: 'ことば',
                          ),
                          onChanged: onChangeQuery,
                        ),
                      ),
                    ],
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
