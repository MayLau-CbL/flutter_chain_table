import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_chain_table_method_channel.dart';

abstract class FlutterChainTablePlatform extends PlatformInterface {
  /// Constructs a FlutterChainTablePlatform.
  FlutterChainTablePlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterChainTablePlatform _instance = MethodChannelFlutterChainTable();

  /// The default instance of [FlutterChainTablePlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterChainTable].
  static FlutterChainTablePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterChainTablePlatform] when
  /// they register themselves.
  static set instance(FlutterChainTablePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
