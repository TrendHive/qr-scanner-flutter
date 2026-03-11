import 'dart:async';

import 'package:core/constants.dart';
import 'package:domain_ui/values/qr_scanner_local_keys.dart';
import 'package:domain_ui/widgets/scaffold/qr_scanner_scaffold.dart';
import 'package:domain_ui/widgets/text/qr_scanner_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:presentation/home/body/home_body.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const int detectionTimeoutSeconds = 1;
  static const int cleanupIntervalMilliseconds = 500;

  MobileScannerController controller = MobileScannerController();
  List<Barcode> barcodes = [];
  List<Barcode> historyBarcodes = [];
  List<Barcode> clickedBarcodes = [];
  Size? previewSize;
  DateTime? lastDetectionTime;
  Timer? cleanupTimer;

  @override
  void initState() {
    super.initState();
    cleanupTimer = Timer.periodic(
      const Duration(milliseconds: cleanupIntervalMilliseconds),
      (timer) {
        if (lastDetectionTime != null) {
          final elapsed = DateTime.now().difference(lastDetectionTime!);
          if (elapsed > Duration(seconds: detectionTimeoutSeconds)) {
            if (mounted && barcodes.isNotEmpty) {
              setState(() {
                barcodes.clear();
              });
            }
          }
        }
      },
    );
  }

  @override
  void dispose() {
    cleanupTimer?.cancel();
    controller.dispose();
    super.dispose();
  }

  void handleDetection(BarcodeCapture capture) {
    setState(() {
      barcodes = capture.barcodes;
      previewSize = capture.size;
      lastDetectionTime = DateTime.now();
    });
    for (final newBarcode in capture.barcodes) {
      final String? rawValue = newBarcode.rawValue;
      if (rawValue == null) continue;
      historyBarcodes.removeWhere((item) => item.rawValue == rawValue);
      historyBarcodes.insert(0, newBarcode);
    }
    setState(() {});
  }

  void onBarcodeTap(Barcode barcode) {
    if (barcode.rawValue == null) return;
    setState(() {
      clickedBarcodes.removeWhere((b) => b.rawValue == barcode.rawValue);
      clickedBarcodes.insert(CoreConstants.zero, barcode);
    });
    if (CoreConstants.urlPattern.hasMatch(barcode.rawValue!)) {
      launchUrlString(barcode.rawValue!);
    } else {
      final text = barcode.rawValue ?? CoreConstants.empty;
      Clipboard.setData(ClipboardData(text: text));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: QRScannerText(QRScannerLocalKeys.of(context)!.copyMessage),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return QRScannerScaffold(
      body: HomeBody(
        controller: controller,
        barcodes: barcodes,
        historyBarcodes: historyBarcodes,
        clickedBarcodes: clickedBarcodes,
        previewSize: previewSize,
        onDetect: handleDetection,
        onBarcodeTap: onBarcodeTap,
      ),
    );
  }
}
