import 'package:core/constants.dart';
import 'package:core_ui/values/base_dimens.dart';
import 'package:domain_ui/values/qr_scanner_color.dart';
import 'package:domain_ui/values/qr_scanner_local_keys.dart';
import 'package:domain_ui/widgets/container/qr_scanner_container.dart';
import 'package:domain_ui/widgets/text/qr_scanner_text.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeListSheet extends StatefulWidget {
  final List<Barcode> historyBarcodes;
  final List<Barcode> clickedBarcodes;
  final void Function(Barcode barcode) onBarcodeTap;

  const BarcodeListSheet({
    super.key,
    required this.historyBarcodes,
    required this.clickedBarcodes,
    required this.onBarcodeTap,
  });

  @override
  State<BarcodeListSheet> createState() => _BarcodeListSheetState();
}

class _BarcodeListSheetState extends State<BarcodeListSheet> {
  static const double _panelWidthFactor = 0.80;
  static const int _animationDurationMs = 300;
  static const double _rotationTurnOpen = 0.5;
  static const double _rotationTurnClosed = 0.0;
  static const double _handleIconSize = 28.0;

  bool _isOpened = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final l10n = QRScannerLocalKeys.of(context);
    final colors = QRScannerColor(context);

    final double panelWidth = size.width * _panelWidthFactor;
    final double handleSize = BaseDimens.padding.xxxxLarge;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: _animationDurationMs),
      curve: Curves.easeInOut,
      left: _isOpened ? CoreConstants.zero.toDouble() : -panelWidth,
      top: CoreConstants.zero.toDouble(),
      bottom: CoreConstants.zero.toDouble(),
      width: panelWidth + handleSize,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          // 1. Panel Gövdesi
          Positioned(
            left: CoreConstants.zeroDouble,
            top: CoreConstants.zeroDouble,
            bottom: CoreConstants.zeroDouble,
            width: panelWidth,
            child: QRScannerContainer(
              decoration: BoxDecoration(
                color: colors.background01.withValues(
                  alpha: BaseDimens.opacity.xxLarge,
                ),
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(BaseDimens.radius.xLarge),
                ),
                boxShadow: [
                  BoxShadow(
                    color: QRScannerColor.black.withValues(
                      alpha: BaseDimens.opacity.xxxxxxSmall,
                    ),
                    blurRadius: BaseDimens.radius.xMedium,
                  ),
                ],
              ),
              child: SafeArea(
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(BaseDimens.padding.xxxxMedium),
                        child: QRScannerText(
                          l10n!.clickedTitle,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colors.primaryButton,
                          ),
                        ),
                      ),
                    ),
                    if (widget.clickedBarcodes.isEmpty)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: BaseDimens.padding.xxxxMedium,
                          ),
                          child: QRScannerText(
                            l10n.emptyClicked,
                            style: TextStyle(
                              color: colors.fontColorDesc.withValues(
                                alpha: BaseDimens.opacity.medium,
                              ),
                            ),
                          ),
                        ),
                      )
                    else
                      SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final item = widget.clickedBarcodes[index];
                          final uri = Uri.tryParse(
                            item.rawValue ?? CoreConstants.empty,
                          );
                          final isUrl = uri != null && uri.hasAbsolutePath;

                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor:
                                  (isUrl
                                          ? colors.primaryButton
                                          : colors.brandDefault)
                                      .withValues(
                                        alpha: BaseDimens.opacity.xxxxxxSmall,
                                      ),
                              child: Icon(
                                isUrl ? Icons.open_in_new : Icons.star_rounded,
                                color: isUrl
                                    ? colors.primaryButton
                                    : colors.brandDefault,
                                size: BaseDimens.padding.xxLarge,
                              ),
                            ),
                            title: QRScannerText(
                              isUrl
                                  ? (uri.host.isNotEmpty
                                        ? uri.host
                                        : item.rawValue!)
                                  : (item.rawValue ?? CoreConstants.empty),
                              maxLines: CoreConstants.one.toInt(),
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: colors.fontColorTitle,
                              ),
                            ),
                            onTap: () => widget.onBarcodeTap(item),
                          );
                        }, childCount: widget.clickedBarcodes.length),
                      ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(BaseDimens.padding.xxxxMedium),
                        child: QRScannerText(
                          l10n.historyTitle,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colors.fontColorTitle,
                          ),
                        ),
                      ),
                    ),
                    if (widget.historyBarcodes.isEmpty)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: BaseDimens.padding.xxxxMedium,
                          ),
                          child: QRScannerText(
                            l10n.emptyHistory,
                            style: TextStyle(
                              color: colors.fontColorDesc.withValues(
                                alpha: BaseDimens.opacity.medium,
                              ),
                            ),
                          ),
                        ),
                      )
                    else
                      SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final item = widget.historyBarcodes[index];
                          final uri = Uri.tryParse(
                            item.rawValue ?? CoreConstants.empty,
                          );
                          final isUrl = uri != null && uri.hasAbsolutePath;

                          return ListTile(
                            leading: Icon(
                              isUrl ? Icons.link : Icons.history,
                              color: isUrl
                                  ? colors.functionButton
                                  : colors.fontColorDesc,
                            ),
                            title: QRScannerText(
                              isUrl
                                  ? (uri.host.isNotEmpty
                                        ? uri.host
                                        : item.rawValue!)
                                  : (item.rawValue ?? CoreConstants.empty),
                              maxLines: CoreConstants.one.toInt(),
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: colors.fontColorTitle,
                              ),
                            ),
                            onTap: () => widget.onBarcodeTap(item),
                          );
                        }, childCount: widget.historyBarcodes.length),
                      ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: CoreConstants.zeroDouble,
            child: QRScannerContainer(
              width: handleSize,
              height: handleSize * 1.5,
              decoration: BoxDecoration(
                color: colors.background01.withValues(
                  alpha: BaseDimens.opacity.xxLarge,
                ),
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(handleSize),
                ),
                boxShadow: [
                  BoxShadow(
                    color: QRScannerColor.black.withValues(
                      alpha: BaseDimens.opacity.xxxxxxSmall,
                    ),
                    offset: const Offset(2, CoreConstants.zeroDouble),
                    blurRadius: BaseDimens.radius.small,
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => setState(() => _isOpened = !_isOpened),
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(handleSize),
                  ),
                  child: Center(
                    child: AnimatedRotation(
                      turns: _isOpened
                          ? _rotationTurnOpen
                          : _rotationTurnClosed,
                      duration: const Duration(
                        milliseconds: _animationDurationMs,
                      ),
                      child: Icon(
                        Icons.chevron_right,
                        size: _handleIconSize,
                        color: colors.fontColorTitle,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
