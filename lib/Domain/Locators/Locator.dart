import 'package:get_it/get_it.dart';
import 'package:qhub/Domain/Api/Client/SignUpModel.dart';
import 'package:qhub/Domain/Api/Client/ClientModel.dart';

var locator = GetIt.instance;

void initLocator() {
  locator.registerFactory<SignUpModel>(() => SignUpModel());
  locator.registerSingleton<ClientModel>(ClientModel());
}
