import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:qhub/Domain/Core/Client/Client.dart';
import 'package:qhub/Domain/Core/FlashbarController.dart';

var locator = GetIt.instance;

void initLocator() {
  locator.registerSingleton<FlashbarController>(FlashbarController());
}
