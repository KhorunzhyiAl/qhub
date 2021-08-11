import 'package:get_it/get_it.dart';
import 'package:qhub/Domain/Service.dart';
import 'package:qhub/Domain/Utils.dart';

var locator = GetIt.instance;

void initLocator() {
  locator.registerSingleton<Service>(Service(Utils.SERVER_ADDRESS));
}
