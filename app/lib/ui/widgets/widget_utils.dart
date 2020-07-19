import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shiritori/intl/intl.dart';
import 'package:shiritori/theme/theme.dart';

const emptyWidget = SizedBox();

const emptyWideWidget = SizedBox(width: double.infinity);

const emptyExpandedWidget = SizedBox.expand();

const verticalMargin2 = SizedBox(height: 2.0);
const verticalMargin4 = SizedBox(height: 4.0);
const verticalMargin6 = SizedBox(height: 6.0);
const verticalMargin8 = SizedBox(height: 8.0);
const verticalMargin12 = SizedBox(height: 12.0);
const verticalMargin16 = SizedBox(height: 16.0);
const verticalMargin20 = SizedBox(height: 20.0);
const verticalMargin22 = SizedBox(height: 22.0);
const verticalMargin24 = SizedBox(height: 24.0);
const verticalMargin32 = SizedBox(height: 32.0);
const verticalMargin36 = SizedBox(height: 36.0);

const horizontalMargin2 = SizedBox(width: 2.0);
const horizontalMargin4 = SizedBox(width: 4.0);
const horizontalMargin6 = SizedBox(width: 6.0);
const horizontalMargin8 = SizedBox(width: 8.0);
const horizontalMargin12 = SizedBox(width: 12.0);
const horizontalMargin16 = SizedBox(width: 16.0);
const horizontalMargin20 = SizedBox(width: 20.0);
const horizontalMargin22 = SizedBox(width: 22.0);
const horizontalMargin24 = SizedBox(width: 24.0);
const horizontalMargin32 = SizedBox(width: 32.0);
const horizontalMargin36 = SizedBox(width: 36.0);

const leftSafePadding = _MediaQueryPadding(left: true);
const topSafePadding = _MediaQueryPadding(top: true);
const rightSafePadding = _MediaQueryPadding(right: true);
const bottomSafePadding = _MediaQueryPadding(bottom: true);

class _MediaQueryPadding extends StatelessWidget {
  const _MediaQueryPadding({
    Key key,
    this.left = false,
    this.top = false,
    this.right = false,
    this.bottom = false,
  }) : super(key: key);

  final bool left;
  final bool top;
  final bool right;
  final bool bottom;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final leftPadding = !left ? 0.0 : padding.left;
    final topPadding = !top ? 0.0 : padding.top;
    final rightPadding = !right ? 0.0 : padding.right;
    final bottomPadding = !bottom ? 0.0 : padding.bottom;

    return SizedBox(
      width: leftPadding + rightPadding,
      height: topPadding + bottomPadding,
    );
  }
}

/// Surrounds its [child] with a [SizedBox]
/// with size `MediaQuery.of(context).size`,
/// allowing the [child] to fill it.
class Fill extends StatelessWidget {
  /// Surrounds its [child] with a [SizedBox]
  /// with size `MediaQuery.of(context).size`,
  /// allowing the [child] to fill it.
  const Fill({
    Key key,
    this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox.fromSize(
      size: size,
      child: child,
    );
  }
}

void _showSnackBar({
  @required BuildContext context,
  @required String message,
  Duration duration,
}) {
  final state = Scaffold.of(context);
  final intl = ShiritoriLocalizations.of(context).ui;

  state
    ..removeCurrentSnackBar(reason: SnackBarClosedReason.dismiss)
    ..showSnackBar(
      SnackBar(
        action: SnackBarAction(
          label: intl.snackBarConfirmButton,
          textColor: AppTheme.lightBlue,
          onPressed: () {
            state.removeCurrentSnackBar(reason: SnackBarClosedReason.dismiss);
          },
        ),
        behavior: SnackBarBehavior.floating,
        content: Text(message),
        duration: duration ?? const Duration(seconds: 4),
      ),
    );
}

void _showExceptionSnackBar({
  @required BuildContext context,
  @required Exception exception,
  Duration duration,
}) {
  String errorMessage;
  print(exception.runtimeType);
  if (exception is PlatformException) {
    errorMessage = exception.message;
  } else {
    errorMessage = exception.toString();
  }
  _showSnackBar(
    message: errorMessage,
    context: context,
    duration: duration,
  );
}

mixin WidgetUtils on StatelessWidget {
  void showSnackBar({
    @required BuildContext context,
    @required String message,
    Duration duration,
  }) {
    return _showSnackBar(
      context: context,
      message: message,
      duration: duration,
    );
  }

  void showExceptionSnackBar({
    BuildContext context,
    @required Exception exception,
    Duration duration,
  }) {
    return _showExceptionSnackBar(
      context: context,
      exception: exception,
      duration: duration,
    );
  }
}

mixin StateUtils<T extends StatefulWidget> on State<T> {
  void showSnackBar({
    BuildContext context,
    @required String message,
    Duration duration,
  }) {
    return _showSnackBar(
      context: context ?? this.context,
      message: message,
      duration: duration,
    );
  }

  void showExceptionSnackBar({
    BuildContext context,
    @required Exception exception,
    Duration duration,
  }) {
    return _showExceptionSnackBar(
      context: context ?? this.context,
      exception: exception,
      duration: duration,
    );
  }
}
