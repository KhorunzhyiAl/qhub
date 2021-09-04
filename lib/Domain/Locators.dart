import 'package:get_it/get_it.dart';
import 'package:qhub/Domain/Client/Client.dart';
import 'package:qhub/Domain/Core/FlashbarController.dart';

var locator = GetIt.instance;

void initLocator() {
  locator.registerLazySingleton<Client>(() => Client());
  locator.registerSingleton<FlashbarController>(FlashbarController());
}
