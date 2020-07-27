import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shiritori/intl/intl.dart';
import 'package:shiritori/theme/theme.dart';
import 'package:shiritori/ui/widgets/widgets.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    Key key,
    this.automaticallyImplyLeading = true,
    this.title,
    this.child,
  })  : assert(automaticallyImplyLeading != null),
        super(key: key);

  final bool automaticallyImplyLeading;
  final Widget title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final uiIntl = ShiritoriLocalizations.of(context).ui;

    final theme = Theme.of(context);

    final route = ModalRoute.of(context);
    final showBackButton = automaticallyImplyLeading && route.canPop;

    final navBarColor =
        theme.brightness == Brightness.light ? AppTheme.white : AppTheme.black;

    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: true,
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        backgroundColor: navBarColor.withOpacity(0.5),
        middle: title == null
            ? null
            : DefaultTextStyle(
                style: theme.textTheme.headline6,
                child: title,
              ),
        leading: !showBackButton
            ? null
            : TextButton(
                onTap: Navigator.of(context).pop,
                child: Text(uiIntl.back),
              ),
      ),
      child: SizedBox.expand(
        child: child,
      ),
    );
  }
}
