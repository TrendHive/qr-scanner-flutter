import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:presentation/home/items/barcode_hover_item.dart';

class HomeBody extends StatelessWidget {
  final MobileScannerController controller;
  final List<Barcode> barcodes;
  final Size? previewSize;
  final void Function(BarcodeCapture barcodes) onDetect;
  final void Function(Barcode barcode) onBarcodeTap;

  const HomeBody({
    super.key,
    required this.controller,
    required this.barcodes,
    required this.previewSize,
    required this.onDetect,
    required this.onBarcodeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MobileScanner(controller: controller, onDetect: onDetect),
        ...barcodes.map(
          (barcode) => BarcodeHoverItem(
            barcode: barcode,
            previewSize: previewSize ?? MediaQuery.of(context).size,
            screenSize: MediaQuery.of(context).size,
            onTap: () => onBarcodeTap(barcode),
          ),
        ),
      ],
    );
  }
}
