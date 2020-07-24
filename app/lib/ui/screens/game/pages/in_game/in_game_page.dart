import 'package:flutter/material.dart';
import 'package:shiritori/backend/backend.dart';
import 'package:shiritori/theme/theme.dart';
import 'package:shared_models/shared_models.dart';
import 'package:shiritori/ui/screens/game/pages/in_game/widgets/widgets.dart';

class InGamePage extends StatefulWidget {
  const InGamePage({Key key}) : super(key: key);

  @override
  _InGamePageState createState() => _InGamePageState();
}

class _InGamePageState extends State<InGamePage> {
  final _scrollController = ScrollController();
  Game _game;
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _game = Game.of(context, listen: false)..addListener(onUpdateGame);
  }

  @override
  void dispose() {
    _game?.removeListener(onUpdateGame);
    _focusNode?.unfocus();
    super.dispose();
  }

  Future<void> onUpdateGame() async {
    setState(() {});

    await Future.delayed(const Duration(milliseconds: 1));

    await _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: AppTheme.curveDefault,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final startingCharacter = _game.startingCharacterForNextGuess;
          final nextWord = _game.settings.dictionary
              .searchWordsThatStartsWith(startingCharacter)
              .random
              .phoneticSpellings
              .whereOrEmpty(_game.settings.dictionary.language.validate)
              .randomOrNull;

          _game.addGuess(nextWord);
        },
        child: const Icon(Icons.add),
      ),
      body: ListView(
        controller: _scrollController,
        children: [
          for (final playerGuessWithEntry
              in _game.allGuessesWithWordEntriesByPlayerIndex)
            GuessDetailsCard(
              backgroundColor:
                  playerGuessWithEntry.left == 1 ? AppTheme.blue : null,
              guessWithEntry: playerGuessWithEntry.right,
            ),
        ],
      ),
    );
  }
}
