import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_chain_table/flutter_chain_table.dart';
import 'package:flutter_chain_table/flutter_chain_table_platform_interface.dart';
import 'package:flutter_chain_table/flutter_chain_table_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterChainTablePlatform
    with MockPlatformInterfaceMixin
    implements FlutterChainTablePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterChainTablePlatform initialPlatform = FlutterChainTablePlatform.instance;

  test('$MethodChannelFlutterChainTable is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterChainTable>());
  });

  test('getPlatformVersion', () async {
    FlutterChainTable flutterChainTablePlugin = FlutterChainTable();
    MockFlutterChainTablePlatform fakePlatform = MockFlutterChainTablePlatform();
    FlutterChainTablePlatform.instance = fakePlatform;

    expect(await flutterChainTablePlugin.getPlatformVersion(), '42');
  });
}
