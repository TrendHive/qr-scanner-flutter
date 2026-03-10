import 'dart:async';

import 'package:core/constants.dart';
import 'package:domain_ui/values/qr_scanner_local_keys.dart';
import 'package:domain_ui/widgets/scaffold/qr_scanner_scaffold.dart';
import 'package:domain_ui/widgets/text/qr_scanner_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:presentation/home/body/home_body.dart';
import 'package:url_launcher/url_launcher.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return QRScannerScaffold(
      body: HomeBody(
        controller: controller,
        barcodes: barcodes,
        previewSize: previewSize,
        onDetect: handleDetection,
        onBarcodeTap: (barcode) {
          if (barcode.rawValue == null) return;
          Uri? uri = Uri.tryParse(barcode.rawValue!);
          if (uri != null && uri.hasAbsolutePath) {
            launchUrl(uri);
          } else {
            final text = barcode.rawValue ?? CoreConstants.empty;
            Clipboard.setData(ClipboardData(text: text));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: QRScannerText(
                  QRScannerLocalKeys.of(context)!.copyMessage,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
