import 'package:flutter/material.dart';
import 'package:shiritori/backend/backend.dart';
import 'package:shiritori/theme/theme.dart';
import 'package:shiritori/ui/screens/game/pages/in_game/widgets/widgets.dart';

class InGamePage extends StatefulWidget {
  const InGamePage({Key key}) : super(key: key);

  @override
  _InGamePageState createState() => _InGamePageState();
}

class _InGamePageState extends State<InGamePage> {
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode?.unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final game = Game.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      body: Center(
        child: Theme(
          data: theme.copyWith(
            cardTheme: theme.cardTheme.copyWith(
              color: AppTheme.blue,
            ),
            textTheme: theme.textTheme.apply(
              bodyColor: AppTheme.white,
              displayColor: AppTheme.white,
            ),
          ),
          child: WordEntryDetailsCard(
            wordEntry: game.settings.dictionary
                .searchWord(game.guessesByPlayerIndex[1].last)
                .first,
          ),
        ),
      ),
    );
  }
}
