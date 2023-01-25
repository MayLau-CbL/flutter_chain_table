import 'package:flutter/material.dart';

typedef TableWidgetBuilder = Widget Function(
    BuildContext context, int rowIndex, int colIndex);

class SideTable extends StatelessWidget {
  final ScrollController verticalScrollController;
  final ScrollController horizontalScrollController;

  final bool reverse;
  final int tableColumnCount;
  final int tableRowCount;
  final TableWidgetBuilder tableWidgetBuilder;

  const SideTable({
    super.key,
    required this.tableColumnCount,
    required this.tableRowCount,
    required this.tableWidgetBuilder,
    required this.verticalScrollController,
    required this.horizontalScrollController,
    this.reverse = false,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: reverse,
      controller: horizontalScrollController,
      scrollDirection: Axis.horizontal,
      child: ListView.builder(
        itemCount: tableRowCount,
        padding: EdgeInsets.zero,
        controller: verticalScrollController,
        itemBuilder: ((context, rowIndex) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(tableColumnCount, (colIndex) {
              return tableWidgetBuilder(context, rowIndex, colIndex);
            }),
          );
        }),
      ),
    );
  }
}
