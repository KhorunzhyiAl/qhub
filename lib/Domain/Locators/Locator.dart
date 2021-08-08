import 'package:get_it/get_it.dart';
import 'package:qhub/Domain/Models/LogInFormModel.dart';
import 'package:qhub/Domain/Models/SignUpFormModel.dart';
import 'package:qhub/Domain/Services/ClientService.dart';

var locator = GetIt.instance;

void initLocator() {
  locator.registerFactory<SignUpFormModel>(() => SignUpFormModel());
  locator.registerFactory<LogInFormModel>(() => LogInFormModel());
  locator.registerSingleton<ClientService>(ClientService());
}
