import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:plateron/core/injection/injection.config.dart';
import 'package:plateron/core/navigation/app_router.dart';

final GetIt locator = GetIt.instance;

@InjectableInit()
Future<void> configureInjection() async {
  locator.registerSingleton<AppRouter>(AppRouter());
  await locator.init();
}
