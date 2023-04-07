import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chain_table/flutter_chain_table.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late List _testList;
  final int _price = 115;

  LinkedScrollControllerGroup _verticalScrollControllerGroup =
      LinkedScrollControllerGroup();

  @override
  void initState() {
    super.initState();
    Random random = Random();
    _testList = List.generate(50, (index) {
      return {
        'strike': index + 90,
        'call': {
          'last': random.nextInt(5) * 0.01,
          'bid': random.nextInt(5) * 0.01,
          'ask': random.nextInt(5) * 0.01,
        },
        'put': {
          'last': random.nextInt(5) * 0.01,
          'bid': random.nextInt(5) * 0.01,
          'ask': random.nextInt(5) * 0.01,
        }
      };
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _verticalScrollControllerGroup.jumpTo(50 * 21);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Chain Table Example'),
        ),
        body: ChainTable(
          verticalLinkedScroll: _verticalScrollControllerGroup,
          leftTableHeaderColumnCount: 3,
          rightTableHeaderColumnCount: 3,
          leftTableFooterColumnCount: 3,
          rightTableFooterColumnCount: 3,
          leftTableWidth: 240,
          rightTableWidth: 240,
          centerColumnWidth: 80,
          leftTableColumnCount: 3,
          rightTableColumnCount: 3,
          tableRowCount: 50,
          centerTableFooterBuilder: (context, index) {
            return CellWidget(
              'Strike',
              backgroundColor: Colors.grey.shade200,
            );
          },
          leftTableFooterBuilder: (context, index) {
            switch (index) {
              case 0:
                {
                  return const CellWidget(
                    'Last',
                  );
                }
              case 1:
                {
                  return const CellWidget(
                    'Ask',
                  );
                }

              default:
                {
                  return const CellWidget(
                    'Bid',
                  );
                }
            }
          },
          rightTableFooterBuilder: (context, index) {
            switch (index) {
              case 0:
                {
                  return const CellWidget('Bid');
                }
              case 1:
                {
                  return const CellWidget('Ask');
                }
              default:
                {
                  return const CellWidget('Last');
                }
            }
          },
          centerTableHeaderBuilder: (context, index) {
            return CellWidget(
              'Strike',
              backgroundColor: Colors.grey.shade200,
            );
          },
          leftTableHeaderBuilder: (context, index) {
            switch (index) {
              case 0:
                {
                  return const CellWidget(
                    'Last',
                  );
                }
              case 1:
                {
                  return const CellWidget(
                    'Ask',
                  );
                }

              default:
                {
                  return const CellWidget(
                    'Bid',
                  );
                }
            }
          },
          rightTableHeaderBuilder: (context, index) {
            switch (index) {
              case 0:
                {
                  return const CellWidget('Bid');
                }
              case 1:
                {
                  return const CellWidget('Ask');
                }
              default:
                {
                  return const CellWidget('Last');
                }
            }
          },
          leftBuilder: (context, rowIndex, colIndex) {
            Color color = _testList[rowIndex]['strike'] < _price
                ? Colors.lightBlue.shade100
                : Colors.transparent;
            switch (colIndex) {
              case 0:
                {
                  return CellWidget(
                    _testList[rowIndex]['call']['last'].toString(),
                    backgroundColor: color,
                  );
                }
              case 1:
                {
                  return CellWidget(
                    _testList[rowIndex]['call']['ask'].toString(),
                    backgroundColor: color,
                  );
                }

              default:
                {
                  return CellWidget(
                    _testList[rowIndex]['call']['bid'].toString(),
                    backgroundColor: color,
                  );
                }
            }
          },
          rightBuilder: (context, rowIndex, colIndex) {
            Color color = _testList[rowIndex]['strike'] >= _price
                ? Colors.lightBlue.shade100
                : Colors.transparent;
            switch (colIndex) {
              case 0:
                {
                  return CellWidget(
                    _testList[rowIndex]['put']['bid'].toString(),
                    backgroundColor: color,
                  );
                }
              case 1:
                {
                  return CellWidget(
                    _testList[rowIndex]['put']['ask'].toString(),
                    backgroundColor: color,
                  );
                }

              default:
                {
                  return CellWidget(
                    _testList[rowIndex]['put']['last'].toString(),
                    backgroundColor: color,
                  );
                }
            }
          },
          centerBuilder: (context, index) {
            Color color = _testList[index]['strike'] == _price
                ? Colors.lightBlue.shade300
                : Colors.lightBlue.shade200;
            return CellWidget(
              _testList[index]['strike'].toString(),
              backgroundColor: color,
            );
          },
        ),
      ),
    );
  }
}

class CellWidget extends StatelessWidget {
  final String value;
  final Color backgroundColor;

  const CellWidget(
    this.value, {
    super.key,
    this.backgroundColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        color: backgroundColor,
        width: 80.0,
        height: 50,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              child: Center(child: Text(value)),
            ),
            const Divider(
              height: 1.0,
              thickness: 1.0,
              color: Colors.grey,
            )
          ],
        ));
  }
}
