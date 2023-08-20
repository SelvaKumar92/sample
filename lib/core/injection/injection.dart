import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:plateron/core/injection/injection.config.dart';

final GetIt locator = GetIt.instance;

@InjectableInit()
Future<void> configureInjection() async {
  await locator.init();
}
