import 'package:flutter/cupertino.dart';

class HorizontalLinePainter extends CustomPainter {
  final Color color;

  HorizontalLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [const Color(0xFF1D2228), color, const Color(0xFF1D2228)],
      ).createShader(
        Rect.fromPoints(Offset(0, 0), Offset(size.width, 0)),
      )
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(Offset(0, 0), Offset(size.width, 0), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class VerticalLinePainter extends CustomPainter {
  final Color color;

  VerticalLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [const Color(0xFF1D2228), color, const Color(0xFF1D2228)],
      ).createShader(
        Rect.fromPoints(Offset(0, 0), Offset(0, size.height)),
      )
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(Offset(0, 0), Offset(0, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}