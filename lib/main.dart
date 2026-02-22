import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loynova_assessment/core/router/app_router.dart';

import 'core/constants.dart';
import 'core/di/injection.dart';
import 'features/wallet/domain/repositories/wallet_repository.dart';
import 'features/wallet/presentation/manager/wallet_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await init();

  // Bloc.observer = MyBlocObserver();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const ShopPlusApp(),
    ),
  );
}

class ShopPlusApp extends StatelessWidget {
  const ShopPlusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WalletBloc(getIt<WalletRepository>()),
        ),
      ],
      child: MaterialApp.router(
        title: Constants.appName,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(useMaterial3: true),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
