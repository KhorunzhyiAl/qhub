import 'package:get_it/get_it.dart';
import 'package:qhub/Domain/Api/Client/LogInFormModel.dart';
import 'package:qhub/Domain/Api/Client/SignUpFormModel.dart';
import 'package:qhub/Domain/Api/Client/ClientModel.dart';

var locator = GetIt.instance;

void initLocator() {
  locator.registerFactory<SignUpModel>(() => SignUpModel());
  locator.registerFactory<LogInFormModel>(() => LogInFormModel());
  locator.registerSingleton<ClientModel>(ClientModel());
}
