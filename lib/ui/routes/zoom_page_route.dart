import 'package:flutter/widgets.dart';
import 'package:shiritori/theme/theme.dart';

class ZoomPageRoute extends PageRouteBuilder {
  ZoomPageRoute({
    @required final WidgetBuilder builder,
  })  : assert(builder != null),
        super(
          transitionDuration: const Duration(milliseconds: 350),
          transitionsBuilder: (context, animationIn, animationOut, child) {
            final curve = AppTheme.curveDefault;
            final reverseCurve = curve.flipped;

            final opacityAnimationIn = CurvedAnimation(
              parent: animationIn,
              curve: curve,
              reverseCurve: reverseCurve,
            );
            final opacityAnimationOut = CurvedAnimation(
              parent: animationOut.drive(Tween(begin: 1.0, end: 0.0)),
              // TODO: Determine best looking approach.
              //
              // Note: in practice, this curve is flipped because of how the
              //   value is used within the transition.
              //
              // If `curve: curve` is set, the page will lose opacity very
              //   slowly at the start and then drop off sharp near the end
              //   (essentially the same as `curve.flipped`,
              //   i.e., `reverseCurve`).
              // If `curve: reverseCurve` is set, the animation will exhibit
              //   the behavior expected of `curve` (unflipped), and the
              //   opacity will start with a fast dropoff and then slowly
              //   settles.
              curve: curve,
              reverseCurve: curve,
            );
            final scaleAnimationIn = CurvedAnimation(
              parent: animationIn,
              curve: curve,
              reverseCurve: reverseCurve,
            ).drive(Tween(begin: 0.8, end: 1.0));
            final scaleAnimationOut = CurvedAnimation(
              parent: animationOut,
              curve: curve,
              reverseCurve: reverseCurve,
            ).drive(Tween(begin: 1.0, end: 1.2));

            return FadeTransition(
              opacity: opacityAnimationIn,
              child: FadeTransition(
                opacity: opacityAnimationOut,
                child: ScaleTransition(
                  alignment: Alignment.center,
                  scale: scaleAnimationIn,
                  child: ScaleTransition(
                    scale: scaleAnimationOut,
                    child: child,
                  ),
                ),
              ),
            );
          },
          pageBuilder: (context, animation, secondAnimation) {
            return builder(context);
          },
        );
}
