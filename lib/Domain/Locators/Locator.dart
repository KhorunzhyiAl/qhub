import 'package:get_it/get_it.dart';
import 'package:qhub/Domain/Api/Client/SignUpModel.dart';


var locator = GetIt.instance;

void initLocator() {
  locator.registerLazySingleton<SignUpModel>(() => SignUpModel());
}
