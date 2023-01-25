import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

import 'side_table.dart';

class BaseChainTable extends StatefulWidget {
  /// table horizontal width
  final double leftTableWidth, rightTableWidth;

  final int leftTableColumnCount, rightTableColumnCount;
  final int tableRowCount;

  /// table cell builder
  final TableWidgetBuilder leftBuilder, rightBuilder;
  final IndexedWidgetBuilder centerBuilder;

  final LinkedScrollControllerGroup horizontalLinkedScroll;
  final LinkedScrollControllerGroup verticalLinkedScroll;

  const BaseChainTable({
    super.key,
    required this.leftTableWidth,
    required this.rightTableWidth,
    required this.leftTableColumnCount,
    required this.rightTableColumnCount,
    required this.leftBuilder,
    required this.rightBuilder,
    required this.centerBuilder,
    required this.tableRowCount,
    required this.horizontalLinkedScroll,
    required this.verticalLinkedScroll,
  });

  @override
  State<BaseChainTable> createState() => _BaseChainTableState();
}

class _BaseChainTableState extends State<BaseChainTable> {
  late ScrollController _horizontalLeftScollController;
  late ScrollController _horizontalRightScollController;

  late ScrollController _verticalLeftScollController;
  late ScrollController _verticalCenterScollController;
  late ScrollController _verticalRightScollController;

  @override
  void initState() {
    super.initState();

    _initHorizontalScrollControllers();
    _initVerticalScrollControllers();
  }

  void _initHorizontalScrollControllers() {
    _horizontalLeftScollController = widget.horizontalLinkedScroll.addAndGet();
    _horizontalRightScollController = widget.horizontalLinkedScroll.addAndGet();
  }

  void _initVerticalScrollControllers() {
    _verticalLeftScollController = widget.verticalLinkedScroll.addAndGet();
    _verticalCenterScollController = widget.verticalLinkedScroll.addAndGet();
    _verticalRightScollController = widget.verticalLinkedScroll.addAndGet();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SideTable(
          reverse: true,
          verticalScrollController: _verticalLeftScollController,
          horizontalScrollController: _horizontalLeftScollController,
          tableColumnCount: widget.leftTableColumnCount,
          tableRowCount: widget.tableRowCount,
          tableWidgetBuilder: widget.leftBuilder,
        ),
        ListView.builder(
          itemCount: widget.tableRowCount,
          controller: _verticalCenterScollController,
          itemBuilder: widget.centerBuilder,
        ),
        SideTable(
          verticalScrollController: _verticalRightScollController,
          horizontalScrollController: _horizontalRightScollController,
          tableColumnCount: widget.rightTableColumnCount,
          tableRowCount: widget.tableRowCount,
          tableWidgetBuilder: widget.rightBuilder,
        ),
      ],
    );
  }
}
