import 'package:get_it/get_it.dart';
import 'package:kmitl_fitness_app/util/services/dialog_service.dart';

GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  locator.registerLazySingleton(() => DialogService());
}
