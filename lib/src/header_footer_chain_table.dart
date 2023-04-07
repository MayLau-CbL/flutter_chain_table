import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

import 'base_chain_table.dart';
import 'model/footer_info.dart';
import 'model/header_info.dart';
import 'side_table.dart';

class HeaderFooterChainTable extends StatefulWidget {
  final HeaderInfo? headerInfo;

  final FooterInfo? footerInfo;

  final double leftTableWidth, rightTableWidth, centerColumnWidth;
  final int leftTableColumnCount, rightTableColumnCount;
  final int tableRowCount;

  /// table cell builder
  final TableWidgetBuilder leftBuilder, rightBuilder;
  final IndexedWidgetBuilder centerBuilder;

  final double widgetHeight, widgetWidth;

  final LinkedScrollControllerGroup horizontalLinkedScroll;
  final LinkedScrollControllerGroup verticalLinkedScroll;

  const HeaderFooterChainTable({
    super.key,
    required this.widgetHeight,
    required this.widgetWidth,
    required this.leftTableWidth,
    required this.rightTableWidth,
    required this.centerColumnWidth,
    required this.leftTableColumnCount,
    required this.rightTableColumnCount,
    required this.tableRowCount,
    required this.leftBuilder,
    required this.rightBuilder,
    required this.centerBuilder,
    this.headerInfo,
    this.footerInfo,
    required this.horizontalLinkedScroll,
    required this.verticalLinkedScroll,
  });

  @override
  State<HeaderFooterChainTable> createState() => _HeaderFooterChainTableState();
}

class _HeaderFooterChainTableState extends State<HeaderFooterChainTable> {
  late ScrollController _horizontalLeftHeaderScollController;
  late ScrollController _horizontalRightHeaderScollController;

  late ScrollController _horizontalLeftFooterScollController;
  late ScrollController _horizontalRightFooterScollController;

  @override
  void initState() {
    super.initState();

    _initHorizontalScrollHeaderControllers();
    _initHorizontalScrollFooterControllers();
  }

  void _initHorizontalScrollHeaderControllers() {
    bool hasHeader = widget.headerInfo != null;
    if (hasHeader) {
      _horizontalLeftHeaderScollController =
          widget.horizontalLinkedScroll.addAndGet();
      _horizontalRightHeaderScollController =
          widget.horizontalLinkedScroll.addAndGet();
    }
  }

  void _initHorizontalScrollFooterControllers() {
    bool hasFooter = widget.footerInfo != null;
    if (hasFooter) {
      _horizontalLeftFooterScollController =
          widget.horizontalLinkedScroll.addAndGet();
      _horizontalRightFooterScollController =
          widget.horizontalLinkedScroll.addAndGet();
    }
  }

  @override
  Widget build(BuildContext context) {
    double sideTableWidth = (widget.widgetWidth - widget.centerColumnWidth) / 2;

    return CustomMultiChildLayout(
      delegate: TableHeaderFooterLayoutDelegate(
        centerColumnWidth: widget.centerColumnWidth,
        widgetWidth: widget.widgetWidth,
        widgetHeight: widget.widgetHeight,
      ),
      children: [
        LayoutId(
          id: TableComponents.body,
          child: BaseChainTable(
            verticalLinkedScroll: widget.verticalLinkedScroll,
            horizontalLinkedScroll: widget.horizontalLinkedScroll,
            widgetWidth: widget.widgetWidth,
            leftTableWidth: widget.leftTableWidth,
            rightTableWidth: widget.rightTableWidth,
            centerColumnWidth: widget.centerColumnWidth,
            leftTableColumnCount: widget.leftTableColumnCount,
            rightTableColumnCount: widget.rightTableColumnCount,
            leftBuilder: widget.leftBuilder,
            rightBuilder: widget.rightBuilder,
            centerBuilder: widget.centerBuilder,
            tableRowCount: widget.tableRowCount,
          ),
        ),
        if (widget.headerInfo?.leftTableHeaderBuilder != null)
          LayoutId(
            id: TableComponents.leftHeader,
            child: SizedBox(
              width: sideTableWidth,
              child: SingleChildScrollView(
                reverse: true,
                controller: _horizontalLeftHeaderScollController,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                      widget.headerInfo!.leftTableHeaderColumnCount, (index) {
                    return widget.headerInfo!.leftTableHeaderBuilder
                        .call(context, index);
                  }),
                ),
              ),
            ),
          ),
        if (widget.headerInfo?.centerTableHeaderBuilder != null)
          LayoutId(
            id: TableComponents.centerHeader,
            child: SizedBox(
              width: widget.centerColumnWidth,
              child: Row(
                children: List.generate(
                    widget.headerInfo!.centerTableHeaderColumnCount, (index) {
                  return widget.headerInfo!.centerTableHeaderBuilder
                      .call(context, index);
                }),
              ),
            ),
          ),
        if (widget.headerInfo?.rightTableHeaderBuilder != null)
          LayoutId(
            id: TableComponents.rightHeader,
            child: SizedBox(
              width: sideTableWidth,
              child: SingleChildScrollView(
                controller: _horizontalRightHeaderScollController,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                      widget.headerInfo!.rightTableHeaderColumnCount, (index) {
                    return widget.headerInfo!.rightTableHeaderBuilder
                        .call(context, index);
                  }),
                ),
              ),
            ),
          ),
        if (widget.footerInfo?.leftTableFooterBuilder != null)
          LayoutId(
            id: TableComponents.leftFooter,
            child: SizedBox(
              width: sideTableWidth,
              child: SingleChildScrollView(
                controller: _horizontalLeftFooterScollController,
                reverse: true,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                      widget.footerInfo!.leftTableFooterColumnCount, (index) {
                    return widget.footerInfo!.leftTableFooterBuilder
                        .call(context, index);
                  }),
                ),
              ),
            ),
          ),
        if (widget.footerInfo?.centerTableFooterBuilder != null)
          LayoutId(
            id: TableComponents.centerFooter,
            child: SizedBox(
              width: widget.centerColumnWidth,
              child: Row(
                children: List.generate(
                    widget.footerInfo!.centerTableFooterColumnCount, (index) {
                  return widget.footerInfo!.centerTableFooterBuilder
                      .call(context, index);
                }),
              ),
            ),
          ),
        if (widget.footerInfo?.rightTableFooterBuilder != null)
          LayoutId(
            id: TableComponents.rightFooter,
            child: SizedBox(
              width: sideTableWidth,
              child: SingleChildScrollView(
                controller: _horizontalRightFooterScollController,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                      widget.footerInfo!.rightTableFooterColumnCount, (index) {
                    return widget.footerInfo!.rightTableFooterBuilder
                        .call(context, index);
                  }),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class TableHeaderFooterLayoutDelegate extends MultiChildLayoutDelegate {
  final double widgetWidth, widgetHeight;
  final double centerColumnWidth;

  TableHeaderFooterLayoutDelegate({
    required this.centerColumnWidth,
    required this.widgetWidth,
    required this.widgetHeight,
  });

  @override
  void performLayout(Size size) {
    double leftTableWidth = (widgetWidth - centerColumnWidth) / 2;
    double rightTableWidth = (widgetWidth - centerColumnWidth) / 2;

    Size leftHeaderSize = Size.zero,
        centerHeaderSize = Size.zero,
        rightHeaderSize = Size.zero,
        bodySize = Size.zero,
        leftFooterSize = Size.zero,
        centerFooterSize = Size.zero,
        rightFooterSize = Size.zero;

    bool hasHeader = hasChild(TableComponents.leftHeader) &&
        hasChild(TableComponents.centerHeader) &&
        hasChild(TableComponents.rightHeader);

    if (hasHeader) {
      leftHeaderSize = layoutChild(TableComponents.leftHeader,
          BoxConstraints.tightFor(width: leftTableWidth));
      centerHeaderSize = layoutChild(TableComponents.centerHeader,
          BoxConstraints.tightFor(width: centerColumnWidth));
      rightHeaderSize = layoutChild(TableComponents.rightHeader,
          BoxConstraints.tightFor(width: rightTableWidth));

      assert(
          leftHeaderSize.height == centerHeaderSize.height &&
              rightHeaderSize.height == centerHeaderSize.height,
          "Headers should sharing the same height");
    }

    bool hasFooter = hasChild(TableComponents.leftFooter) &&
        hasChild(TableComponents.centerFooter) &&
        hasChild(TableComponents.rightFooter);
    if (hasFooter) {
      leftFooterSize = layoutChild(TableComponents.leftFooter,
          BoxConstraints.tightFor(width: leftTableWidth));
      centerFooterSize = layoutChild(TableComponents.centerFooter,
          BoxConstraints.tightFor(width: centerColumnWidth));
      rightFooterSize = layoutChild(TableComponents.rightFooter,
          BoxConstraints.tightFor(width: rightTableWidth));
      assert(
          leftFooterSize.height == centerFooterSize.height &&
              rightFooterSize.height == centerFooterSize.height,
          "Footers should sharing the same height");
    }

    bool hasBody = hasChild(TableComponents.body);
    if (hasBody) {
      double bodyHeight = widgetHeight -
          (hasHeader ? centerHeaderSize.height : 0) -
          (hasFooter ? centerFooterSize.height : 0);

      assert(bodyHeight >= 0, "Table body should not be smaller than zero.");

      bodySize = layoutChild(
        TableComponents.body,
        BoxConstraints.tightFor(
          width: widgetWidth,
          height: bodyHeight,
        ),
      );
    }

    if (hasHeader) {
      positionChild(TableComponents.leftHeader, Offset.zero);
      positionChild(TableComponents.centerHeader, Offset(leftTableWidth, 0));
      positionChild(TableComponents.rightHeader,
          Offset(widgetWidth - rightTableWidth, 0));
    }
    if (hasBody) {
      positionChild(TableComponents.body, Offset(0, leftHeaderSize.height));
    }
    if (hasFooter) {
      double footerOffsetY = leftHeaderSize.height + bodySize.height;
      positionChild(TableComponents.leftFooter, Offset(0, footerOffsetY));
      positionChild(
          TableComponents.centerFooter, Offset(leftTableWidth, footerOffsetY));
      positionChild(TableComponents.rightFooter,
          Offset(widgetWidth - rightTableWidth, footerOffsetY));
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    if (oldDelegate is TableHeaderFooterLayoutDelegate) {
      return centerColumnWidth != oldDelegate.centerColumnWidth ||
          widgetHeight != oldDelegate.widgetHeight ||
          widgetWidth != oldDelegate.widgetWidth;
    }
    return true;
  }
}

enum TableComponents {
  leftHeader,
  centerHeader,
  rightHeader,
  body,
  leftFooter,
  centerFooter,
  rightFooter,
}
