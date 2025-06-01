import 'package:core_ui/widgets/button/base_text_button.dart';
import 'package:domain_ui/widgets/text/qr_scanner_text.dart';
import 'package:flutter/material.dart';

class QRScannerTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonStyle? style;

  const QRScannerTextButton(
    this.text, {
    super.key,
    this.onPressed,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return BaseTextButton(
      onPressed: onPressed,
      style: style,
      child: QRScannerText(text),
    );
  }
}
