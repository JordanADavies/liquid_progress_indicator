import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/src/wave.dart';

class LiquidCustomProgressIndicator extends ProgressIndicator {
  ///The widget to show in the center of the progress indicator.
  final Widget? center;

  ///The direction the liquid travels.
  final Axis direction;

  ///The path used to draw the shape of the progress indicator. The size of the progress indicator is controlled by the bounds of this path.
  final Path shapePath;

  LiquidCustomProgressIndicator({
    Key? key,
    double value = 0.5,
    Color? backgroundColor,
    Animation<Color>? valueColor,
    this.center,
    required this.direction,
    required this.shapePath,
  }) : super(
          key: key,
          value: value,
          backgroundColor: backgroundColor,
          valueColor: valueColor,
        );

  Color _getBackgroundColor(BuildContext context) =>
      backgroundColor ?? Theme.of(context).backgroundColor;

  Color _getValueColor(BuildContext context) =>
      valueColor?.value ?? Theme.of(context).colorScheme.secondary;

  @override
  State<StatefulWidget> createState() => _LiquidCustomProgressIndicatorState();
}

class _LiquidCustomProgressIndicatorState
    extends State<LiquidCustomProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    final pathBounds = widget.shapePath.getBounds();
    return SizedBox(
      width: pathBounds.width + pathBounds.left,
      height: pathBounds.height + pathBounds.top,
      child: ClipPath(
        clipper: _CustomPathClipper(
          path: widget.shapePath,
        ),
        child: CustomPaint(
          painter: _CustomPathPainter(
            color: widget._getBackgroundColor(context),
            path: widget.shapePath,
          ),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                left: pathBounds.left,
                top: pathBounds.top,
                child: Wave(
                  value: widget.value,
                  color: widget._getValueColor(context),
                  direction: widget.direction,
                ),
              ),
              if (widget.center != null) Center(child: widget.center),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomPathPainter extends CustomPainter {
  final Color color;
  final Path path;

  _CustomPathPainter({required this.color, required this.path});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_CustomPathPainter oldDelegate) =>
      color != oldDelegate.color || path != oldDelegate.path;
}

class _CustomPathClipper extends CustomClipper<Path> {
  final Path path;

  _CustomPathClipper({required this.path});

  @override
  Path getClip(Size size) {
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
