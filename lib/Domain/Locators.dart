import 'package:cookie_jar/cookie_jar.dart';
import 'package:get_it/get_it.dart';
import 'package:qhub/Domain/Service/Client.dart';

var locator = GetIt.instance;

void initLocator() {
  locator.registerLazySingleton<Client>(() => Client());
}
