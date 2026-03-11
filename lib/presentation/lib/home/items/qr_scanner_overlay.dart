import 'package:core_ui/values/base_dimens.dart';
import 'package:domain_ui/values/qr_scanner_color.dart';
import 'package:flutter/material.dart';
import 'scanner_painter.dart'; // Yeni dosyayı import et

class QRScannerOverlay extends StatefulWidget {
  const QRScannerOverlay({super.key});

  @override
  State<QRScannerOverlay> createState() => _QRScannerOverlayState();
}

class _QRScannerOverlayState extends State<QRScannerOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  static const Duration _animationDuration = Duration(seconds: 2);
  static const double _scanAreaScale = 0.7;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _animationDuration, vsync: this)
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scannerColor = QRScannerColor(context);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size.infinite,
          painter: ScannerPainter(
            borderColor: scannerColor.primaryButton,
            overlayColor: QRScannerColor.black.withValues(
              alpha: BaseDimens.opacity.medium,
            ),
            borderRadius: BaseDimens.radius.medium,
            scanLineOffset: _controller.value,
            scanAreaScale: _scanAreaScale,
          ),
        );
      },
    );
  }
}
