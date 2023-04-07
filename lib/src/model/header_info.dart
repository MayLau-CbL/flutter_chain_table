import 'package:flutter/widgets.dart';

class HeaderInfo {
  /// An [IndexedWidgetBuilder] as left header builder. Index start from right to left.
  final IndexedWidgetBuilder leftTableHeaderBuilder;

  /// An [IndexedWidgetBuilder] as right header builder. Index start from left to right.
  final IndexedWidgetBuilder rightTableHeaderBuilder;

  /// An [IndexedWidgetBuilder] as right header builder. Index always equal to ZERO.
  final IndexedWidgetBuilder centerTableHeaderBuilder;

  /// The number of Column in header. Left and right column count must > 0.
  final int leftTableHeaderColumnCount,
      rightTableHeaderColumnCount,
      centerTableHeaderColumnCount = 1;

  HeaderInfo({
    required this.leftTableHeaderBuilder,
    required this.rightTableHeaderBuilder,
    required this.centerTableHeaderBuilder,
    required this.leftTableHeaderColumnCount,
    required this.rightTableHeaderColumnCount,
  })  : assert(leftTableHeaderColumnCount > 0,
            "leftTableHeaderColumnCount must not be ZERO"),
        assert(rightTableHeaderColumnCount > 0,
            "rightTableHeaderColumnCount must not be ZERO");
}
