import 'package:domain_ui/values/qr_scanner_local_keys.dart';
import 'package:domain_ui/values/qr_scanner_theme.dart';
import 'package:flutter/material.dart';
import 'package:presentation/router/qr_scanner_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: QRScannerRouter().getRouter(),
      localizationsDelegates: QRScannerLocalKeys.localizationsDelegates,
      supportedLocales: QRScannerLocalKeys.supportedLocales,
      title: QRScannerLocalKeys.title,
      theme: QRScannerTheme.lightTheme,
      darkTheme: QRScannerTheme.darkTheme,
    );
  }
}
