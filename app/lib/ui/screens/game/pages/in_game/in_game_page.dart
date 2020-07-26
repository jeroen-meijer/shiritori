import 'package:flutter/material.dart';
import 'package:shiritori/backend/backend.dart';
import 'package:shiritori/theme/theme.dart';
import 'package:shiritori/ui/screens/game/game.dart';
import 'package:shiritori/ui/widgets/widgets.dart';

class InGamePage extends StatefulWidget {
  const InGamePage({
    Key key,
    this.onRestart,
  }) : super(key: key);

  final VoidCallback onRestart;

  @override
  _InGamePageState createState() => _InGamePageState();
}

class _InGamePageState extends State<InGamePage> {
  final _scrollController = ScrollController();
  final _textController = TextEditingController();
  Game _game;

  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.attach(context);
    _game = Game.of(context, listen: false)..addListener(_onUpdateGame);
  }

  @override
  void dispose() {
    _game?.removeListener(_onUpdateGame);
    _focusNode?.unfocus();
    _focusNode?.dispose();
    super.dispose();
  }

  Future<void> _onUpdateGame() async {
    setState(() {});

    if (_game.winningPlayerIndex != null) {
      _focusNode.unfocus();
    }

    await Future.delayed(const Duration(milliseconds: 100));

    await _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: AppTheme.curveDefault,
    );
  }

  void _onSubmitGuess(String text) {
    final value = text.trim();

    if (value == null) {
      return;
    }

    setState(() {
      _textController.clear();
      final transformed = _game.language.mapToLanguage(value);
      _game.addGuess(transformed);
    });
  }

  Widget _buildGuessDetailsCard(int index) {
    final playerGuess = _game.allGuessesByPlayerIndex.elementAt(index);
    final playerIndex = playerGuess.left;

    const sidePadding = 36.0;

    return Padding(
      padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 6.0,
          ) +
          EdgeInsets.only(
            left: playerIndex == 0 ? sidePadding : 0,
            right: playerIndex == 1 ? sidePadding : 0,
          ),
      child: GuessDetailsCard(
        key: Key('guess-details-card-$index'),
        index: index,
        guess: playerGuess.right,
        backgroundColor: playerIndex == 1 ? AppTheme.blue : null,
        animationDirection:
            playerIndex.isEven ? AxisDirection.left : AxisDirection.right,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final nextCharHint = Tuple(
      _game.startingCharacterForNextGuess,
      _game.language.mapFromLanguage(_game.startingCharacterForNextGuess),
    );
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).padding.top),
                  for (var index = 0;
                      index < _game.allGuessesByPlayerIndex.length;
                      index++)
                    _buildGuessDetailsCard(index),
                  verticalMargin16,
                ],
              ),
            ),
          ),
          if (_game.isFinished) ...[
            Material(
              color: AppTheme.blue,
              child: InkWell(
                onTap: widget.onRestart,
                child: SizedBox(
                  width: double.infinity,
                  height: 64.0,
                  child: Center(
                    child: DefaultTextStyle(
                      // TODO: Refactor to separate button stuff
                      style: Theme.of(context).textTheme.button.copyWith(
                            color: AppTheme.colorButtonForegroundPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                          ),
                      // TODO: intl
                      child: const Text('Restart'),
                    ),
                  ),
                ),
              ),
            )
          ] else
            TextField(
              controller: _textController,
              focusNode: _focusNode,
              readOnly: _game.isFinished,
              autofocus: true,
              keyboardType: TextInputType.text,
              minLines: 1,
              maxLines: 1,
              onSubmitted: _onSubmitGuess,
              onEditingComplete: () {
                // Do nothing. Prevents keyboard from hiding.
              },
              decoration: InputDecoration(
                hintText: nextCharHint.fold((left, right) => '$left/$right'),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                  borderSide: BorderSide(
                    color: AppTheme.blue,
                    width: 4.0,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
