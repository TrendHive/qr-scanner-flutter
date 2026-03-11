import 'package:core/constants.dart';
import 'package:core/logger/local_logger.dart';
import 'package:core_ui/values/base_dimens.dart';
import 'package:domain_ui/values/qr_scanner_color.dart';
import 'package:domain_ui/widgets/container/qr_scanner_container.dart';
import 'package:domain_ui/widgets/text/qr_scanner_text.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeHoverItem extends StatefulWidget {
  final Barcode barcode;
  final Size previewSize;
  final Size screenSize;
  final VoidCallback onTap;

  const BarcodeHoverItem({
    super.key,
    required this.barcode,
    required this.previewSize,
    required this.screenSize,
    required this.onTap,
  });

  @override
  State<BarcodeHoverItem> createState() => _BarcodeHoverItemState();
}

class _BarcodeHoverItemState extends State<BarcodeHoverItem> {
  late Uri? uri;

  @override
  void initState() {
    uri = Uri.tryParse(widget.barcode.rawValue ?? CoreConstants.empty);
    LocalLogger.info(widget.barcode.rawValue ?? CoreConstants.empty);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.barcode.corners.isEmpty) {
      return SizedBox();
    }

    Offset scaleAndOffset() {
      final Offset originalPoint = widget.barcode.corners.first;
      double previewAspectRatio =
          widget.previewSize.width / widget.previewSize.height;
      double screenAspectRatio =
          widget.screenSize.width / widget.screenSize.height;

      double scaleX,
          scaleY,
          offsetX = CoreConstants.zeroDouble,
          offsetY = CoreConstants.zeroDouble;

      if (screenAspectRatio > previewAspectRatio) {
        scaleX = widget.screenSize.width / widget.previewSize.width;
        scaleY = scaleX;
        double fittedHeight = widget.previewSize.height * scaleY;
        offsetY = (widget.screenSize.height - fittedHeight) / 2;
      } else {
        scaleY = widget.screenSize.height / widget.previewSize.height;
        scaleX = scaleY;
        double fittedWidth = widget.previewSize.width * scaleX;
        offsetX = (widget.screenSize.width - fittedWidth) / 2;
      }

      return Offset(
        originalPoint.dx * scaleX + offsetX,
        originalPoint.dy * scaleY + offsetY,
      );
    }

    Size scaleSize() {
      final Size originalSize = widget.barcode.size;
      double previewAspectRatio =
          widget.previewSize.width / widget.previewSize.height;
      double screenAspectRatio =
          widget.screenSize.width / widget.screenSize.height;

      double scale;

      if (screenAspectRatio > previewAspectRatio) {
        scale = widget.screenSize.width / widget.previewSize.width;
      } else {
        scale = widget.screenSize.height / widget.previewSize.height;
      }

      return Size(originalSize.width * scale, originalSize.height * scale);
    }

    return Positioned(
      left: scaleAndOffset().dx,
      top: scaleAndOffset().dy,
      child: AnimatedOpacity(
        duration: Durations.medium2,
        opacity: BaseDimens.opacity.full,
        child: GestureDetector(
          onTap: widget.onTap,
          child: QRScannerContainer(
            padding: EdgeInsets.all(BaseDimens.padding.medium),
            width: scaleSize().width,
            height: scaleSize().height,
            decoration: BoxDecoration(
              color: QRScannerColor(
                context,
              ).primaryButton.withValues(alpha: BaseDimens.opacity.small),
              border: Border.all(color: QRScannerColor(context).primaryButton),
              borderRadius: BorderRadius.circular(BaseDimens.radius.xxMedium),
            ),
            child: Center(
              child: QRScannerText(
                uri != null && (uri?.hasAbsolutePath ?? false)
                    ? uri!.host
                    : widget.barcode.rawValue ?? CoreConstants.empty,
                style: TextStyle(color: QRScannerColor.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
