import 'package:core/constants.dart';
import 'package:core_ui/values/base_dimens.dart';
import 'package:flutter/material.dart';

class ScannerPainter extends CustomPainter {
  final Color borderColor;
  final Color overlayColor;
  final double borderRadius;
  final double scanLineOffset;
  final double scanAreaScale;

  static const double _borderStrokeWidth = 4.0;
  static const double _laserStrokeWidth = 2.0;
  static const double _cornerLineLengthRatio = 0.15;
  static const double _halfMultiplier = 0.5;

  ScannerPainter({
    required this.borderColor,
    required this.overlayColor,
    required this.borderRadius,
    required this.scanLineOffset,
    required this.scanAreaScale,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height;

    final double rectSize = width * scanAreaScale;
    final Rect scanRect = Rect.fromCenter(
      center: Offset(width * _halfMultiplier, height * _halfMultiplier),
      width: rectSize,
      height: rectSize,
    );

    final Paint maskPaint = Paint()..color = overlayColor;
    final Path maskPath = Path()
      ..addRect(
        Rect.fromLTWH(
          CoreConstants.zeroDouble,
          CoreConstants.zeroDouble,
          width,
          height,
        ),
      )
      ..addRRect(
        RRect.fromRectAndRadius(scanRect, Radius.circular(borderRadius)),
      )
      ..fillType = PathFillType.evenOdd;
    canvas.drawPath(maskPath, maskPaint);

    final Paint borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = _borderStrokeWidth
      ..strokeCap = StrokeCap.round;

    final double cornerLineLength = rectSize * _cornerLineLengthRatio;

    _drawCorners(canvas, scanRect, cornerLineLength, borderPaint);

    final Paint laserPaint = Paint()
      ..shader =
          LinearGradient(
            colors: [
              borderColor.withValues(alpha: CoreConstants.zeroDouble),
              borderColor,
              borderColor.withValues(alpha: CoreConstants.zeroDouble),
            ],
          ).createShader(
            Rect.fromLTWH(
              scanRect.left,
              CoreConstants.zeroDouble,
              scanRect.width,
              CoreConstants.zeroDouble,
            ),
          );

    final double laserY = scanRect.top + (scanRect.height * scanLineOffset);
    canvas.drawLine(
      Offset(scanRect.left + BaseDimens.padding.medium, laserY),
      Offset(scanRect.right - BaseDimens.padding.medium, laserY),
      laserPaint..strokeWidth = _laserStrokeWidth,
    );
  }

  void _drawCorners(Canvas canvas, Rect rect, double length, Paint paint) {
    canvas.drawPath(
      Path()
        ..moveTo(rect.left, rect.top + length)
        ..lineTo(rect.left, rect.top + borderRadius)
        ..arcToPoint(
          Offset(rect.left + borderRadius, rect.top),
          radius: Radius.circular(borderRadius),
        )
        ..lineTo(rect.left + length, rect.top),
      paint,
    );

    canvas.drawPath(
      Path()
        ..moveTo(rect.right - length, rect.top)
        ..lineTo(rect.right - borderRadius, rect.top)
        ..arcToPoint(
          Offset(rect.right, rect.top + borderRadius),
          radius: Radius.circular(borderRadius),
        )
        ..lineTo(rect.right, rect.top + length),
      paint,
    );

    canvas.drawPath(
      Path()
        ..moveTo(rect.right, rect.bottom - length)
        ..lineTo(rect.right, rect.bottom - borderRadius)
        ..arcToPoint(
          Offset(rect.right - borderRadius, rect.bottom),
          radius: Radius.circular(borderRadius),
        )
        ..lineTo(rect.right - length, rect.bottom),
      paint,
    );

    canvas.drawPath(
      Path()
        ..moveTo(rect.left + length, rect.bottom)
        ..lineTo(rect.left + borderRadius, rect.bottom)
        ..arcToPoint(
          Offset(rect.left, rect.bottom - borderRadius),
          radius: Radius.circular(borderRadius),
        )
        ..lineTo(rect.left, rect.bottom - length),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant ScannerPainter oldDelegate) {
    return oldDelegate.scanLineOffset != scanLineOffset;
  }
}
