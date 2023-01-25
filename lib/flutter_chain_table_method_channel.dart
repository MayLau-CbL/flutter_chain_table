import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_chain_table_platform_interface.dart';

/// An implementation of [FlutterChainTablePlatform] that uses method channels.
class MethodChannelFlutterChainTable extends FlutterChainTablePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_chain_table');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
