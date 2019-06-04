import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/src/wave.dart';

class LiquidCustomProgressIndicator extends ProgressIndicator {
  ///The width of the border, if this is set [borderColor] must also be set.
  final double borderWidth;

  ///The color of the border, if this is set [borderWidth] must also be set.
  final Color borderColor;

  ///The widget to show in the center of the progress indicator.
  final Widget center;

  ///The direction the liquid travels.
  final Axis direction;

  ///The path used to draw the shape of the progress indicator.
  final Path shapePath;

  LiquidCustomProgressIndicator({
    Key key,
    double value = 0.5,
    Color backgroundColor,
    Animation<Color> valueColor,
    this.borderWidth,
    this.borderColor,
    this.center,
    @required this.direction,
    @required this.shapePath,
  }) : super(
    key: key,
    value: value,
    backgroundColor: backgroundColor,
    valueColor: valueColor,
  ) {
    if (borderWidth != null && borderColor == null ||
        borderColor != null && borderWidth == null) {
      throw ArgumentError("borderWidth and borderColor should both be set.");
    }
  }

  Color _getBackgroundColor(BuildContext context) =>
      backgroundColor ?? Theme
          .of(context)
          .backgroundColor;

  Color _getValueColor(BuildContext context) =>
      valueColor?.value ?? Theme
          .of(context)
          .accentColor;

  @override
  State<StatefulWidget> createState() => _LiquidCustomProgressIndicatorState();
}

class _LiquidCustomProgressIndicatorState
    extends State<LiquidCustomProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.shapePath
          .getBounds()
          .width,
      height: widget.shapePath
          .getBounds()
          .height,
      child: ClipPath(
        clipper: _CustomPathClipper(
          path: widget.shapePath,
        ),
        child: CustomPaint(
          painter: _CustomPathPainter(
            color: widget._getBackgroundColor(context),
            path: widget.shapePath,
          ),
          foregroundPainter: _CustomPathBorderPainter(
            color: widget.borderColor,
            width: widget.borderWidth,
            path: widget.shapePath,
          ),
          child: Stack(
            children: <Widget>[
              Wave(
                value: widget.value,
                color: widget._getValueColor(context),
                direction: widget.direction,
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

  _CustomPathPainter({@required this.color, @required this.path});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_CustomPathPainter oldDelegate) =>
      color != oldDelegate.color || path != oldDelegate.path;
}

class _CustomPathBorderPainter extends CustomPainter {
  final Color color;
  final double width;
  final Path path;

  _CustomPathBorderPainter({
    @required this.color,
    @required this.width,
    @required this.path,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (color == null || width == null) {
      return;
    }

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    final leftTopPath = path.shift(Offset(width / 2, width / 2));
    canvas.drawPath(leftTopPath, paint);

    final rightBottomPath = path.shift(Offset(-width / 2, -width / 2));
    canvas.drawPath(rightBottomPath, paint);
  }

  @override
  bool shouldRepaint(_CustomPathBorderPainter oldDelegate) =>
      color != oldDelegate.color ||
          width != oldDelegate.width ||
          path != oldDelegate.path;
}

class _CustomPathClipper extends CustomClipper<Path> {
  final Path path;

  _CustomPathClipper({@required this.path});

  @override
  Path getClip(Size size) {
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
