import 'package:apps.technical.sera_astra/core/repository/account_repository.dart';
import 'package:apps.technical.sera_astra/core/repository/cart_repository.dart';
import 'package:apps.technical.sera_astra/core/repository/product_repository.dart';
import 'package:apps.technical.sera_astra/core/viewmodel/account_viewmodel.dart';
import 'package:get_it/get_it.dart';

import 'core/repository/auth_repository.dart';
import 'core/viewmodel/auth_viewmodel.dart';
import 'core/viewmodel/base_viewmodel.dart';
import 'core/viewmodel/home_viewmodel.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthRepository());
  locator.registerLazySingleton(() => ProductRepository());
  locator.registerLazySingleton(() => AccountRepository());
  locator.registerLazySingleton(() => CartRepository());

  locator.registerFactory(() => AuthViewModel());
  locator.registerFactory(() => HomeViewModel());
  locator.registerFactory(() => AccountViewModel());
  locator.registerFactory(() => BaseViewModel());
}
