import 'package:get_it/get_it.dart';
import 'package:hive_using/localstorage/locale_storage_impl.dart';
import 'package:hive_using/localstorage/loacle_storage.dart';

abstract class Application {
  static final locator = GetIt.instance;

  static void setUp() {
    locator.registerSingleton<LocaleStorage>(HiveLocaleStorage());
  }
}
