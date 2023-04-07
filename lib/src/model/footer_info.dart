import 'package:flutter/widgets.dart';

class FooterInfo {
  /// An [IndexedWidgetBuilder] as left footer builder. Index start from right to left.
  final IndexedWidgetBuilder leftTableFooterBuilder;

  /// An [IndexedWidgetBuilder] as right footer builder. Index start from left to right.
  final IndexedWidgetBuilder rightTableFooterBuilder;

  /// An [IndexedWidgetBuilder] as right footer builder. Index always equal to ZERO.
  final IndexedWidgetBuilder centerTableFooterBuilder;

  /// The number of Column in footer. Left and right column count must > 0.
  final int leftTableFooterColumnCount,
      rightTableFooterColumnCount,
      centerTableFooterColumnCount = 1;

  FooterInfo({
    required this.leftTableFooterBuilder,
    required this.rightTableFooterBuilder,
    required this.centerTableFooterBuilder,
    required this.leftTableFooterColumnCount,
    required this.rightTableFooterColumnCount,
  })  : assert(leftTableFooterColumnCount > 0,
            "leftTableFooterColumnCount must not be ZERO"),
        assert(rightTableFooterColumnCount > 0,
            "rightTableFooterColumnCount must not be ZERO");
}
