import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

import 'header_footer_chain_table.dart';
import 'model/footer_info.dart';
import 'model/header_info.dart';
import 'side_table.dart';

class ChainTable extends StatefulWidget {
  /// Header information of the table. No header will be shown when [header] is null.
  final HeaderInfo? header;

  /// Footer information of the table. No header will be shown when [footer] is null.
  final FooterInfo? footer;

  /// Left and right table width. Width must > 0.
  final double sideTableWidth;

  /// Center fixed column width. Width must > 0.
  final double centerColumnWidth;

  /// Number of column in left and right table.
  final int leftTableColumnCount, rightTableColumnCount;

  /// Number of table row.
  final int tableRowCount;

  /// Table cell builder.
  final TableWidgetBuilder leftBuilder, rightBuilder;

  /// Center fixed column cell builder.
  final IndexedWidgetBuilder centerBuilder;

  /// Left and right parts including header, footer and table body horizontal scoll controller group. Using google's [linked_scroll_controller] to synchonize the scroll event. Detail may ref to [LinkedScrollControllerGroup].
  final LinkedScrollControllerGroup? horizontalLinkedScroll;

  /// Left and right table and center fixed column vertial scoll controller group. Using google's [linked_scroll_controller] to synchonize the scroll event. Detail may ref to [LinkedScrollControllerGroup].
  final LinkedScrollControllerGroup? verticalLinkedScroll;

  const ChainTable({
    super.key,

    ///Header
    this.header,

    ///Footer
    this.footer,

    ///Body
    required this.sideTableWidth,
    required this.centerColumnWidth,
    required this.leftTableColumnCount,
    required this.rightTableColumnCount,
    required this.tableRowCount,
    required this.leftBuilder,
    required this.rightBuilder,
    required this.centerBuilder,

    ///Scroll Control
    this.horizontalLinkedScroll,
    this.verticalLinkedScroll,
  })  : assert((sideTableWidth > 0),
            "Left and right table width must greater than ZERO"),
        assert((centerColumnWidth > 0),
            "Center table width must greater than ZERO"),
        assert((leftTableColumnCount > 0),
            "Left table column count must greater than ZERO"),
        assert((rightTableColumnCount > 0),
            "Right table column count must greater than ZERO");

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
        headerInfo: widget.header,
        footerInfo: widget.footer,
        widgetHeight: constraint.maxHeight,
        widgetWidth: constraint.maxWidth,
        leftTableWidth: widget.sideTableWidth,
        rightTableWidth: widget.sideTableWidth,
        centerColumnWidth: widget.centerColumnWidth,
        leftTableColumnCount: widget.leftTableColumnCount,
        rightTableColumnCount: widget.rightTableColumnCount,
        tableRowCount: widget.tableRowCount,
        leftBuilder: widget.leftBuilder,
        rightBuilder: widget.rightBuilder,
        centerBuilder: widget.centerBuilder,
        horizontalLinkedScroll: _horizontalLinkedScroll,
        verticalLinkedScroll: _verticalLinkedScroll,
      );
    });
  }
}
