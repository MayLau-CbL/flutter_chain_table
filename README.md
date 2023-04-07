# flutter_chain_table

[![pub package](https://img.shields.io/pub/v/flutter_chain_table.svg)](https://pub.dev/packages/flutter_chain_table)

A flutter table with fixed center column list and two bi-direction tables on left and right side.

# Installation

Run this command to install latest:

```
flutter pub add flutter_chain_table
```

# Usage

This shows Widget's full customizations:
```
const ChainTable({
    super.key,
    this.header,
    this.footer,
    required this.sideTableWidth,
    required this.centerColumnWidth,
    required this.leftTableColumnCount,
    required this.rightTableColumnCount,
    required this.tableRowCount,
    required this.leftBuilder,
    required this.rightBuilder,
    required this.centerBuilder,
    this.horizontalLinkedScroll,
    this.verticalLinkedScroll,
  })
```

# Example

Demo of the example project:

![](https://raw.githubusercontent.com/MayLau-CbL/flutter_chain_table/main/demo.gif)

## License

MIT