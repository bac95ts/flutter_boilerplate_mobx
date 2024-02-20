import 'dart:async';

import 'package:flutter_boilerplate_project/core/stores/error/error_store.dart';
import 'package:flutter_boilerplate_project/core/stores/form/form_store.dart';

import '../../../di/service_locator.dart';

mixin StoreModule {
  static Future<void> configureStoreModuleInjection() async {
    // factories:---------------------------------------------------------------
    getIt.registerFactory(() => ErrorStore());
    getIt.registerFactory(() => FormErrorStore());
    getIt.registerFactory(
      () => FormStore(getIt<FormErrorStore>(), getIt<ErrorStore>()),
    );

    // stores:------------------------------------------------------------------
    // getIt.registerSingleton<UserStore>(
    //   UserStore(
    //     getIt<IsLoggedInUseCase>(),
    //     getIt<SaveLoginStatusUseCase>(),
    //     getIt<LoginUseCase>(),
    //     getIt<FormErrorStore>(),
    //     getIt<ErrorStore>(),
    //   ),
    // );
    //
    // getIt.registerSingleton<PostStore>(
    //   PostStore(
    //     getIt<GetPostUseCase>(),
    //     getIt<ErrorStore>(),
    //   ),
    // );
    //
    // getIt.registerSingleton<ThemeStore>(
    //   ThemeStore(
    //     getIt<SettingRepository>(),
    //     getIt<ErrorStore>(),
    //   ),
    // );
    //
    // getIt.registerSingleton<LanguageStore>(
    //   LanguageStore(
    //     getIt<SettingRepository>(),
    //     getIt<ErrorStore>(),
    //   ),
    // );
  }
}
