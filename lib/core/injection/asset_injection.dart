import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AssetInjection {
  @Singleton()
  final AssetBundle bundle = PlatformAssetBundle();
}
