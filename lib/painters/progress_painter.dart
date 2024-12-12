import 'dart:math';

import 'package:flutter/material.dart';

const circleProgressColor = Color(0xFFE0F7FA);
const circleBgColor = Color(0xFF00509D);

const progressTextSize = 40.0;
const progressTextColor = Colors.white;

class ProgressPainter extends CustomPainter {
  final Animation<double> progress;
  final double circleRadius;
  final double circleStrokeWidth;

  ProgressPainter({
    required this.progress,
    required this.circleRadius,
    this.circleStrokeWidth = 10.0,
  }) : super(repaint: progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    canvas.translate(center.dx, center.dy);

    _drawCircleProgress(canvas);
    _drawProgressText(canvas);
  }

  /// Draws the circular progress background and arc.
  void _drawCircleProgress(Canvas canvas) {
    Paint circlePaint = Paint()
      ..color = circleBgColor
      ..strokeWidth = circleStrokeWidth
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;

    Paint shadow = Paint()
      ..color = Colors.black
      ..strokeWidth = circleStrokeWidth
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 30);

    canvas.drawCircle(
      Offset.zero,
      circleRadius,
      circlePaint,
    );
    canvas.drawCircle(Offset.zero, circleRadius, shadow);

    circlePaint
      ..color = circleProgressColor
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: Offset.zero, radius: circleRadius),
      -0.5 * pi,
      2 * pi * (progress.value / 100),
      false,
      circlePaint,
    );
  }

  /// Draws the progress text.
  void _drawProgressText(Canvas canvas) {
    final textSpan = TextSpan(
      text: "${(progress.value).toInt()}%",
      style: const TextStyle(
        color: progressTextColor,
        fontSize: progressTextSize,
      ),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(
      canvas,
      Offset(-textPainter.width / 2, -textPainter.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
