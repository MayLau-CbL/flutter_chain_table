import 'package:flutter/material.dart';
import 'package:flutter_chain_table/src/header_footer_chain_table.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

import 'side_table.dart';

class ChainTable extends StatefulWidget {
  ///Header
  final IndexedWidgetBuilder? leftTableHeaderBuilder,
      rightTableHeaderBuilder,
      centerTableHeaderBuilder;
  final int leftTableHeaderColumnCount,
      rightTableHeaderColumnCount,
      centerTableHeaderColumnCount = 1;

  ///Footer
  final IndexedWidgetBuilder? leftTableFooterBuilder,
      rightTableFooterBuilder,
      centerTableFooterBuilder;
  final int leftTableFooterColumnCount,
      rightTableFooterColumnCount,
      centerTableFooterColumnCount = 1;

  ///Body
  final double leftTableWidth, rightTableWidth, centerColumnWidth;
  final int leftTableColumnCount, rightTableColumnCount;
  final int tableRowCount;

  /// Table Cell Builder
  final TableWidgetBuilder leftBuilder, rightBuilder;
  final IndexedWidgetBuilder centerBuilder;

  /// ScrollController
  final LinkedScrollControllerGroup? horizontalLinkedScroll;
  final LinkedScrollControllerGroup? verticalLinkedScroll;

  const ChainTable({
    super.key,
    this.leftTableHeaderBuilder,
    this.rightTableHeaderBuilder,
    this.centerTableHeaderBuilder,
    this.leftTableHeaderColumnCount = 0,
    this.rightTableHeaderColumnCount = 0,
    this.leftTableFooterBuilder,
    this.rightTableFooterBuilder,
    this.centerTableFooterBuilder,
    this.leftTableFooterColumnCount = 0,
    this.rightTableFooterColumnCount = 0,
    required this.leftTableWidth,
    required this.rightTableWidth,
    required this.centerColumnWidth,
    required this.leftTableColumnCount,
    required this.rightTableColumnCount,
    required this.tableRowCount,
    required this.leftBuilder,
    required this.rightBuilder,
    required this.centerBuilder,
    this.horizontalLinkedScroll,
    this.verticalLinkedScroll,
  });

  @override
  State<ChainTable> createState() => _ChainTableState();
}

class _ChainTableState extends State<ChainTable> {
  late LinkedScrollControllerGroup _horizontalLinkedScroll;
  late LinkedScrollControllerGroup _verticalLinkedScroll;

  @override
  void initState() {
    super.initState();
    _horizontalLinkedScroll =
        widget.horizontalLinkedScroll ?? LinkedScrollControllerGroup();
    _verticalLinkedScroll =
        widget.verticalLinkedScroll ?? LinkedScrollControllerGroup();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return HeaderFooterChainTable(
        widgetHeight: constraint.maxHeight,
        widgetWidth: constraint.maxWidth,
        leftTableWidth: widget.leftTableWidth,
        rightTableWidth: widget.rightTableWidth,
        centerColumnWidth: widget.centerColumnWidth,
        leftTableColumnCount: widget.leftTableColumnCount,
        rightTableColumnCount: widget.rightTableColumnCount,
        tableRowCount: widget.tableRowCount,
        leftBuilder: widget.leftBuilder,
        rightBuilder: widget.rightBuilder,
        centerBuilder: widget.centerBuilder,
        horizontalLinkedScroll: _horizontalLinkedScroll,
        verticalLinkedScroll: _verticalLinkedScroll,
        leftTableHeaderBuilder: widget.leftTableHeaderBuilder,
        rightTableHeaderBuilder: widget.rightTableHeaderBuilder,
        centerTableHeaderBuilder: widget.centerTableHeaderBuilder,
        leftTableHeaderColumnCount: widget.leftTableHeaderColumnCount,
        rightTableHeaderColumnCount: widget.rightTableHeaderColumnCount,
        leftTableFooterBuilder: widget.leftTableFooterBuilder,
        rightTableFooterBuilder: widget.rightTableFooterBuilder,
        centerTableFooterBuilder: widget.centerTableFooterBuilder,
        leftTableFooterColumnCount: widget.leftTableFooterColumnCount,
        rightTableFooterColumnCount: widget.rightTableFooterColumnCount,
      );
    });
  }
}
