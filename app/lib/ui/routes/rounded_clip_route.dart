import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:shiritori/theme/theme.dart';

/// A [PageRoute] which transitions by expanding a rounded clip from
/// the center of [expandFrom] until the page is fully revealed.
class RoundedClipRoute<T> extends PageRoute<T> {
  RoundedClipRoute({
    @required this.expandFrom,
    this.radius,
    @required this.builder,
    this.curve,
    this.reverseCurve,
    this.opacity,
    this.border = RoundedClipTransition.kDefaultBorder,
    this.shadow = RoundedClipTransition.kDefaultShadow,
    this.maintainState = false,
    this.transitionDuration = const Duration(milliseconds: 500),
  })  : assert(expandFrom != null),
        assert(builder != null),
        assert(maintainState != null),
        assert(transitionDuration != null);

  /// The [BuildContext] of the widget, which is used to determine the center
  /// of the expanding clip circle and its initial dimensions.
  ///
  /// The [RenderObject] which eventually renders the widget, must be a
  /// [RenderBox].
  ///
  /// See also:
  ///
  /// * [RoundedClipTransition.expandingRect], which is what [expandFrom] is
  /// used to calculate.
  final BuildContext expandFrom;

  /// Builds the primary contents of the route.
  final WidgetBuilder builder;

  /// The radius of the transition box.
  final Radius radius;

  /// The curve used when this route is pushed.
  final Curve curve;

  /// The curve used when this route is popped.
  final Curve reverseCurve;

  /// {@macro RoundedClipTransition.opacity}
  final Animatable<double> opacity;

  /// {@macro RoundedClipTransition.border}
  final BoxBorder border;

  /// {@macro RoundedClipTransition.shadow}
  final List<BoxShadow> shadow;

  @override
  final bool maintainState;

  @override
  final Duration transitionDuration;

  // The expandFrom context is used when popping this route, to update the
  // _expandingRect. This is necessary to handle changes to the layout of
  // the routes below this one (e.g. window is resized), therefore they must be
  // kept around.
  @override
  bool get opaque => false;

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  Rect _expandingRect;

  void _updateExpandingRect() {
    setState(() {
      assert(expandFrom.findRenderObject() is RenderBox);
      final expandFromRenderBox = expandFrom.findRenderObject() as RenderBox;
      final expandFromTransform = expandFromRenderBox.getTransformTo(null);
      final navigatorTransform =
          navigator.context.findRenderObject().getTransformTo(null);
      final transform = expandFromTransform
        ..multiply(Matrix4.tryInvert(navigatorTransform));
      _expandingRect = MatrixUtils.transformRect(
        transform,
        Offset.zero & expandFromRenderBox.size,
      );
    });
  }

  @override
  TickerFuture didPush() {
    _updateExpandingRect();
    return super.didPush();
  }

  @override
  bool didPop(T result) {
    _updateExpandingRect();
    return super.didPop(result);
  }

  @override
  Animation<double> createAnimation() {
    return CurvedAnimation(
      parent: super.createAnimation(),
      curve: curve ?? Curves.easeInOutCubic,
      reverseCurve: reverseCurve ?? Curves.easeInOutCubic.flipped,
    );
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) =>
      builder(context);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return RoundedClipTransition(
      animation: animation,
      expandingRect: _expandingRect,
      radius: radius ?? AppTheme.radiusCardDefault,
      opacity: opacity,
      border: border,
      shadow: shadow,
      child: child,
    );
  }
}

/// A widget which reveals its [child] by expanding a rounded clip from
/// the center of [expandingRect] until the child is fully revealed.
///
/// [expandingRect] is a rectangle in the coordinate space of this widget, which
/// contains the clip circle when [animation.value] is `0`.
///
/// When [animation.value] is `1`, the clip circle contains both
/// [expandingRect] and the rectangle which is the bounding box of [child].
///
/// See also:
///
/// * [RoundedClipRoute], which uses this widget.
class RoundedClipTransition extends StatefulWidget {
  /// Creates  widget which reveals its [child] by expanding a rounded clip
  /// from the center of [expandingRect] until the child is fully revealed.
  RoundedClipTransition({
    Key key,
    @required this.animation,
    this.radius,
    @required this.expandingRect,
    @required this.child,
    Animatable<double> opacity,
    this.border = kDefaultBorder,
    this.shadow = kDefaultShadow,
  })  : assert(animation != null),
        assert(expandingRect != null),
        assert(child != null),
        opacity = opacity ?? kDefaultOpacityAnimatable,
        super(key: key);

  /// The default value for [opacity].
  static final kDefaultOpacityAnimatable = TweenSequence([
    TweenSequenceItem(
      tween: Tween(
        begin: .0,
        end: 1.0,
      ),
      weight: 10,
    ),
    TweenSequenceItem(
      weight: 90,
      tween: ConstantTween(1.0),
    ),
  ]);

  /// The default value for [border].
  static const kDefaultBorder = Border.fromBorderSide(BorderSide(
    color: Color(0xFFFFFFFF),
    width: 2,
  ));

  /// The default value for [shadow].
  static const kDefaultShadow = [
    BoxShadow(
      color: Color(0x61000000),
      blurRadius: 100,
    )
  ];

  /// The animation which controls the progress (0 to 1) of the transition.
  final Animation<double> animation;

  /// The rectangle which describes the center and dimension of the clip
  /// circle at [animation.value] `0`.
  ///
  /// The expanding clip circle will always be centered at this rectangle's
  /// center.
  final Rect expandingRect;

  /// The radius of the transition box.
  final Radius radius;

  /// {@template RoundedClipTransition.opacity}
  /// The [Animatable] which is used to fade the transition in and out.
  ///
  /// When this option is not provided or is `null` it defaults to
  /// [kDefaultOpacityAnimatable]. To use a fixed opacity pass something like
  /// `ConstantTween(1.0)`.
  /// {@endtemplate}
  final Animatable<double> opacity;

  /// {@template RoundedClipTransition.border}
  /// The border which is drawn around the clip circle. The default is
  /// [kDefaultBorder]. To disable the border, set [border] to `null`.
  /// {@endtemplate}
  final BoxBorder border;

  /// {@template RoundedClipTransition.shadow}
  /// The shadow which is drawn beneath the clip circle. The default is
  /// [kDefaultShadow]. To disable the shadow, set [shadow] to `null`.
  /// {@endtemplate}
  final List<BoxShadow> shadow;

  /// The widget which is clipped by the clip circle.
  final Widget child;

  @override
  _RoundedClipTransitionState createState() => _RoundedClipTransitionState();
}

class _RoundedClipTransitionState extends State<RoundedClipTransition> {
  /// The widget returned from [build] is cached to prevent unnecessary
  /// rebuilds of the tree managed by the transition. The child is only
  /// rebuild when the configuration in [widget] actually changes (see
  /// [didUpdateWidget]).
  Widget _child;

  @override
  void didUpdateWidget(RoundedClipTransition oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animation != oldWidget.animation ||
        widget.expandingRect != oldWidget.expandingRect ||
        widget.opacity != oldWidget.opacity ||
        widget.border != oldWidget.border ||
        widget.shadow != oldWidget.shadow ||
        widget.child != oldWidget.child) {
      _child = null;
    }
  }

  @override
  Widget build(BuildContext context) => _child ??= _buildChild();

  Widget _buildChild() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final clipRectAnimation = RectTween(
          begin: widget.expandingRect,
          end: _getExpandedClipRect(Rect.fromPoints(
            Offset.zero,
            Offset(constraints.maxWidth, constraints.maxHeight),
          )),
        ).animate(widget.animation);

        final stackChildren = <Widget>[];

        if (widget.shadow != null) {
          stackChildren.add(_buildDecoration(
            clipRectAnimation,
            BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: widget.shadow,
            ),
          ));
        }

        stackChildren.add(_buildChildClipper(clipRectAnimation));

        if (widget.border != null) {
          stackChildren.add(_buildDecoration(
            clipRectAnimation,
            BoxDecoration(
              borderRadius: BorderRadius.all(widget.radius),
              border: widget.border,
            ),
            ignorePointer: true,
          ));
        }

        Widget child = Stack(children: stackChildren);

        if (widget.opacity != null) {
          child = FadeTransition(
            opacity: widget.opacity.animate(widget.animation),
            child: child,
          );
        }

        return child;
      },
    );
  }

  Rect _getExpandedClipRect(Rect contentRect) {
    final circleRadius = [
      contentRect.topLeft,
      contentRect.topRight,
      contentRect.bottomLeft,
      contentRect.bottomRight,
    ]
        .map((corner) => (corner - widget.expandingRect.center).distance)
        .reduce(math.max);

    var rectSize = Size.square(circleRadius * 2);

    if (widget.border != null) {
      rectSize = widget.border.dimensions.inflateSize(rectSize);
    }

    return Rect.fromCenter(
      center: widget.expandingRect.center,
      height: rectSize.height,
      width: rectSize.width,
    );
  }

  ClipRRect _buildChildClipper(Animation<Rect> clipRectAnimation) {
    return ClipRRect(
      clipper: _RectAnimationClipper(
        animation: clipRectAnimation,
        radius: widget.radius,
      ),
      child: widget.child,
    );
  }

  Widget _buildDecoration(
    Animation<Rect> clipRectAnimation,
    Decoration decoration, {
    bool ignorePointer = false,
  }) {
    Widget child = DecoratedBox(decoration: decoration);
    child = ignorePointer ? IgnorePointer(child: child) : child;
    return _AbsolutePositionedTransition(
      rect: clipRectAnimation,
      child: child,
    );
  }
}

/// Animates the position of a [child] in a [Stack] with  absolutely
/// positioned through a [rect].
class _AbsolutePositionedTransition extends AnimatedWidget {
  const _AbsolutePositionedTransition({
    Key key,
    @required Animation<Rect> rect,
    @required this.child,
  })  : assert(rect != null),
        super(key: key, listenable: rect);

  Animation<Rect> get rect => listenable as Animation<Rect>;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Positioned.fromRect(
      rect: rect.value,
      child: child,
    );
  }
}

/// A simple [CustomClipper] which adapts an [Animation<Rect>] to animate the
/// clip rect.
class _RectAnimationClipper extends CustomClipper<RRect> {
  _RectAnimationClipper({
    @required this.animation,
    @required this.radius,
  })  : assert(animation != null),
        super(reclip: animation);

  final Animation<Rect> animation;
  final Radius radius;

  @override
  RRect getClip(Size size) {
    return RRect.fromRectAndRadius(animation.value, radius);
  }

  @override
  bool shouldReclip(_RectAnimationClipper oldClipper) {
    return animation != oldClipper.animation;
  }
}
