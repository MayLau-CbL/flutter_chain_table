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
  final double leftTableWidth, rightTableWidth;
  final int leftTableColumnCount, rightTableColumnCount;
  final int tableRowCount;

  /// Table Cell Builder
  final TableWidgetBuilder leftBuilder, rightBuilder;
  final IndexedWidgetBuilder centerBuilder;

  const ChainTable({
    super.key,
    this.leftTableHeaderBuilder,
    this.rightTableHeaderBuilder,
    this.centerTableHeaderBuilder,
    required this.leftTableHeaderColumnCount,
    required this.rightTableHeaderColumnCount,
    this.leftTableFooterBuilder,
    this.rightTableFooterBuilder,
    this.centerTableFooterBuilder,
    required this.leftTableFooterColumnCount,
    required this.rightTableFooterColumnCount,
    required this.leftTableWidth,
    required this.rightTableWidth,
    required this.leftTableColumnCount,
    required this.rightTableColumnCount,
    required this.tableRowCount,
    required this.leftBuilder,
    required this.rightBuilder,
    required this.centerBuilder,
  });

  @override
  State<ChainTable> createState() => _ChainTableState();
}

class _ChainTableState extends State<ChainTable> {
  final LinkedScrollControllerGroup _horizontalLinkedScroll =
      LinkedScrollControllerGroup();
  final LinkedScrollControllerGroup _verticalLinkedScroll =
      LinkedScrollControllerGroup();

  @override
  Widget build(BuildContext context) {
    Size widgetSize = MediaQuery.of(context).size;

    return HeaderFooterChainTable(
      widgetHeight: widgetSize.height,
      widgetWidth: widgetSize.width,
      leftTableWidth: widget.leftTableWidth,
      rightTableWidth: widget.rightTableWidth,
      leftTableColumnCount: widget.leftTableColumnCount,
      rightTableColumnCount: widget.rightTableColumnCount,
      tableRowCount: widget.tableRowCount,
      leftBuilder: widget.leftBuilder,
      rightBuilder: widget.rightBuilder,
      centerBuilder: widget.centerBuilder,
      horizontalLinkedScroll: _horizontalLinkedScroll,
      verticalLinkedScroll: _verticalLinkedScroll,
    );
  }
}
