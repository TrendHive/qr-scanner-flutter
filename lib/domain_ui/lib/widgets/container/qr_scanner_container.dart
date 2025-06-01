import 'package:flutter/widgets.dart';
import 'package:core_ui/widgets/container/base_container.dart';

class QRScannerContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  final BoxDecoration? decoration;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Widget? child;

  const QRScannerContainer({
    super.key,
    this.width,
    this.height,
    this.color,
    this.decoration,
    this.padding,
    this.margin,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      width: width,
      height: height,
      color: decoration == null ? color : null,
      decoration: decoration,
      padding: padding,
      margin: margin,
      child: child,
    );
  }
}
