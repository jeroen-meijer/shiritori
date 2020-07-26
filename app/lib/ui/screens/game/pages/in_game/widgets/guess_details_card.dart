import 'package:flutter/material.dart';
import 'package:shiritori/backend/backend.dart';
import 'package:shiritori/intl/intl.dart';
import 'package:shiritori/theme/theme.dart';
import 'package:shiritori/ui/widgets/widgets.dart';

class GuessDetailsCard extends StatefulWidget {
  const GuessDetailsCard({
    Key key,
    this.index,
    @required this.guess,
    this.shape,
    this.backgroundColor,
    this.animationDirection = AxisDirection.up,
  })  : assert(animationDirection != null),
        assert(guess != null),
        super(key: key);

  final int index;

  final Guess guess;

  final ShapeBorder shape;

  /// The background color for the card.
  ///
  /// Is overridden if [guess.isInvalid] is `true`.
  final Color backgroundColor;

  /// From what direction this card should animate.
  ///
  /// Defaults to [AxisDirection.up].
  final AxisDirection animationDirection;

  @override
  _GuessDetailsCardState createState() => _GuessDetailsCardState();
}

class _GuessDetailsCardState extends State<GuessDetailsCard>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  Language _language;
  Guess _guess;
  String _highlightedPart;
  String _nonHighlightedPart;
  List<String> _secondarySpellings = const [];
  List<String> _tertiarySpellings = const [];
  List<String> _definitions = const [];

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();

    final game = Game.of(context, listen: false);

    _language = game.settings.dictionary.language;
    _guess = widget.guess;

    _highlightedPart = _language.selectEndingCharacter(_guess.query);
    _nonHighlightedPart = _guess.query.substring(
      0,
      _guess.query.lastIndexOf(_highlightedPart),
    );

    if (_guess.wordExists) {
      _secondarySpellings = List<String>.of(_guess.entry.phoneticSpellings)
        ..remove(_guess.query)
        ..sort((first, second) => second.length.compareTo(first.length));
      _tertiarySpellings = List<String>.of(_guess.entry.spellings)
        ..remove(_guess.query)
        ..sort((first, second) => second.length.compareTo(first.length));
      _definitions = _guess.entry.definitions;
    }
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  Widget _buildHeader(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Supertitle(
          supertitle: Text(_language.mapFromLanguage(_guess.query)),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  style: textTheme.headline4,
                  text: _nonHighlightedPart,
                ),
                TextSpan(
                  style: textTheme.headline4.copyWith(
                    color: _guess.isInvalid ? null : AppTheme.orange,
                  ),
                  text: _highlightedPart,
                ),
              ],
            ),
          ),
        ),
        for (final spelling in _secondarySpellings.take(4))
          Text(
            spelling,
            style: textTheme.headline5.copyWithColor(
              (color) => color.withOpacity(0.7),
            ),
          ),
      ],
    );
  }

  List<Widget> _buildGuessInfo(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return [
      Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          for (final spelling in _tertiarySpellings.take(4))
            Text(
              spelling,
              style: textTheme.headline6.copyWith(
                color: textTheme.bodyText1.color.withOpacity(0.6),
                fontWeight: FontWeight.normal,
              ),
            ),
        ],
      ),
      verticalMargin8,
      for (final definition in _definitions.take(4))
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(' ・ '),
            Expanded(
              child: Text(definition),
            ),
          ],
        ),
    ];
  }

  List<Widget> _buildErrorFooter(BuildContext context) {
    final intl = ShiritoriLocalizations.of(context).game;
    final textTheme = Theme.of(context).textTheme;

    String reason;

    switch (_guess.validity) {
      case GuessValidity.doesNotFollowPattern:
        reason = intl.invalidGuessReasonDoesNotFollowPattern;
        break;
      case GuessValidity.invalidWord:
        reason = intl.invalidGuessReasonInvalidWord;
        break;
      case GuessValidity.alreadyGuessed:
        reason = intl.invalidGuessReasonAlreadyGuessed;
        break;
      case GuessValidity.doesNotExist:
        reason = intl.invalidGuessReasonDoesNotExist;
        break;
      default:
        reason = 'REASON UNKNOWN. THIS MESSAGE SHOULD NOT APPEAR';
    }

    return [
      Text(
        intl.invalidGuessHeader,
        style: textTheme.headline5,
      ),
      verticalMargin8,
      Text(
        reason,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final originalTheme = Theme.of(context);
    Color adjustedBackgroundColor;
    Color adjustedTextColor;

    if (_guess.isInvalid) {
      adjustedBackgroundColor = AppTheme.pink;
      adjustedTextColor = AppTheme.white;
    } else {
      adjustedBackgroundColor =
          widget.backgroundColor ?? originalTheme.cardTheme.color;
      adjustedTextColor = widget.backgroundColor == null
          ? null
          : adjustedBackgroundColor.computeLuminance() > 0.7
              ? AppTheme.darkGrey
              : AppTheme.white;
    }

    final theme = originalTheme.copyWith(
      cardTheme: originalTheme.cardTheme.copyWith(
        color: adjustedBackgroundColor,
        elevation: 3.0,
      ),
      textTheme: originalTheme.textTheme.apply(
        bodyColor: adjustedTextColor,
        displayColor: adjustedTextColor,
      ),
    );

    return Theme(
      data: theme,
      child: Builder(
        builder: (context) {
          return AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              const offsetDelta = 200.0;
              final direction = widget.animationDirection;

              var offsetDx = 0.0;
              if (direction.isLeft) {
                offsetDx = offsetDelta;
              } else if (direction.isRight) {
                offsetDx = offsetDelta * -1;
              }

              var offsetDy = 0.0;
              if (direction.isUp) {
                offsetDy = offsetDelta;
              } else if (direction.isDown) {
                offsetDy = offsetDelta * -1;
              }

              final translationOffset = Offset(offsetDx, offsetDy);

              const curve = Curves.easeOutCubic;

              final opacityAnimation = CurvedAnimation(
                parent: _animationController,
                curve: curve,
              );
              final scaleAnimation = CurvedAnimation(
                parent: _animationController,
                curve: curve,
              ).drive(Tween(begin: 0.75, end: 1.0));
              final translationAnimation = CurvedAnimation(
                parent: _animationController,
                curve: curve,
              ).drive(Tween<Offset>(
                begin: translationOffset,
                end: Offset.zero,
              ));

              return Opacity(
                opacity: opacityAnimation.value,
                child: Transform.scale(
                  scale: scaleAnimation.value,
                  child: Transform.translate(
                    offset: translationAnimation.value,
                    child: child,
                  ),
                ),
              );
            },
            child: Card(
              shape: widget.shape,
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Stack(
                  children: [
                    if (widget.index != null)
                      Align(
                        alignment: Alignment.topRight,
                        child: Text('${widget.index + 1}'),
                      ),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildHeader(context),
                          verticalMargin8,
                          if (_guess.wordExists) ..._buildGuessInfo(context),
                          if (_guess.isInvalid) ...[
                            Divider(
                              color: adjustedTextColor,
                              height: 24.0,
                              thickness: 1.0,
                            ),
                            ..._buildErrorFooter(context),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
