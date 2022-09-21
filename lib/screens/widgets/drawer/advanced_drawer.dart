import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

/// AdvancedDrawer widget.
class CustomAdvancedDrawer extends StatefulWidget {
  const CustomAdvancedDrawer({
    Key key,
    @required this.child,
    @required this.drawer,
    this.controller,
    this.backdropColor,
    this.openRatio = 0.75,
    this.animationDuration = const Duration(milliseconds: 250),
    this.animationCurve,
    this.childDecoration,
    this.animateChildDecoration = true,
    this.rtlOpening = false,
    this.disabledGestures = false,
    this.animationController,
  }) : super(key: key);

  /// Child widget. (Usually widget that represent a screen)
  final Widget child;

  /// Drawer widget. (Widget behind the [child]).
  final Widget drawer;

  /// Controller that controls widget state.
  final AdvancedDrawerController controller;

  /// Backdrop color.
  final Color backdropColor;

  /// Opening ratio.
  final double openRatio;

  /// Animation duration.
  final Duration animationDuration;

  /// Animation curve.
  final Curve animationCurve;

  /// Child container decoration in open widget state.
  final BoxDecoration childDecoration;

  /// Indicates that [childDecoration] might be animated or not.
  /// NOTICE: It may cause animation jerks.
  final bool animateChildDecoration;

  /// Opening from Right-to-left.
  final bool rtlOpening;

  /// Disable gestures.
  final bool disabledGestures;

  /// Controller that controls widget animation.
  final AnimationController animationController;

  @override
  _CustomAdvancedDrawerState createState() => _CustomAdvancedDrawerState();
}

class _CustomAdvancedDrawerState extends State<CustomAdvancedDrawer>
  with SingleTickerProviderStateMixin {
    AdvancedDrawerController _controller;
    AnimationController _animationController;
    Animation<double> _drawerScaleAnimation;
    Animation<Offset> _childSlideAnimation;
    Animation<double> _childScaleAnimation;
    Animation<Decoration> _childDecorationAnimation;
   double _offsetValue;
   Offset _freshPosition;
  Offset _startPosition;
  bool _captured = false;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ?? AdvancedDrawerController();
    _controller.addListener(handleControllerChanged);

    _animationController = widget.animationController ??
        AnimationController(
          vsync: this,
          value: _controller.value.visible ? 1 : 0,
        );

    _animationController.duration = widget.animationDuration;

    final parentAnimation = widget.animationCurve != null
        ? CurvedAnimation(
            curve: widget.animationCurve,
            parent: _animationController,
          )
        : _animationController;

    _drawerScaleAnimation = Tween<double>(
      begin: 0.75,
      end: 1.0,
    ).animate(parentAnimation);

    _childSlideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(widget.openRatio, 0),
    ).animate(parentAnimation);

    _childScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.85,
    ).animate(parentAnimation);

    _childDecorationAnimation = DecorationTween(
      begin: const BoxDecoration(),
      end: widget.childDecoration,
    ).animate(parentAnimation);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.backdropColor,
      child: GestureDetector(
        onHorizontalDragStart:
            widget.disabledGestures ? null : _handleDragStart,
        onHorizontalDragUpdate:
            widget.disabledGestures ? null : _handleDragUpdate,
        onHorizontalDragEnd: widget.disabledGestures ? null : _handleDragEnd,
        onHorizontalDragCancel:
            widget.disabledGestures ? null : _handleDragCancel,
        child: Container(
          //color: Colors.transparent,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/partyBackground1.jpg'),
              fit: BoxFit.cover
            ),
          ),
          child: Stack(
            children: <Widget>[
              // -------- DRAWER
              Align(
                alignment: widget.rtlOpening
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: widget.openRatio,
                  child: ScaleTransition(
                    scale: _drawerScaleAnimation,
                    alignment: widget.rtlOpening
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: widget.drawer,
                  ),
                ),
              ),
              // -------- CHILD
              SlideTransition(
                position: _childSlideAnimation,
                textDirection:
                    widget.rtlOpening ? TextDirection.rtl : TextDirection.ltr,
                child: ScaleTransition(
                  scale: _childScaleAnimation,
                  child: Builder(
                    builder: (_) {
                      final childStack = Stack(
                        children: [
                          widget.child,
                          ValueListenableBuilder<AdvancedDrawerValue>(
                            valueListenable: _controller,
                            builder: (_, value, __) {
                              if (!value.visible) {
                                return const SizedBox();
                              }

                              return Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: _controller.hideDrawer,
                                  highlightColor: Colors.deepPurpleAccent[700].withOpacity(0.3),
                                  child: Container(),
                                ),
                              );
                            },
                          ),
                        ],
                      );

                      if (widget.animateChildDecoration &&
                          widget.childDecoration != null) {
                        return AnimatedBuilder(
                          animation: _childDecorationAnimation,
                          builder: (_, child) {
                            return Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: _childDecorationAnimation.value,
                              child: child,
                            );
                          },
                          child: childStack,
                        );
                      }

                      return Container(
                        clipBehavior: widget.childDecoration != null
                            ? Clip.antiAlias
                            : Clip.none,
                        decoration: widget.childDecoration,
                        child: childStack,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void handleControllerChanged() {
    _controller.value.visible
        ? _animationController.forward()
        : _animationController.reverse();
  }

  void _handleDragStart(DragStartDetails details) {
    _captured = true;
    _startPosition = details.globalPosition;
    _offsetValue = _animationController.value;
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (!_captured) return;

    final screenSize = MediaQuery.of(context).size;

    _freshPosition = details.globalPosition;

    final diff = (_freshPosition - _startPosition).dx;

    _animationController.value = _offsetValue +
        (diff / (screenSize.width * widget.openRatio)) *
            (widget.rtlOpening ? -1 : 1);
  }

  void _handleDragEnd(DragEndDetails details) {
    if (!_captured) return;

    _captured = false;

    if (_animationController.value >= 0.5) {
      if (_controller.value.visible) {
        _animationController.forward();
      } else {
        _controller.showDrawer();
      }
    } else {
      if (!_controller.value.visible) {
        _animationController.reverse();
      } else {
        _controller.hideDrawer();
      }
    }
  }

  void _handleDragCancel() {
    _captured = false;
  }

  @override
  void dispose() {
    _controller.removeListener(handleControllerChanged);

    if (widget.controller == null) {
      _controller.dispose();
    }

    if (widget.animationController == null) {
      _animationController.dispose();
    }

    super.dispose();
  }
}
