import 'package:go_router/go_router.dart';
import 'package:loynova_assessment/features/transfer_points/presentation/pages/transfer_points_screen.dart';
import '../../features/wallet/presentation/pages/wallet_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: Routes.wallet,
    routes: [
      GoRoute(
        path: Routes.wallet,
        name: Routes.wallet.replaceAll('/', ''),
        builder: (context, state) => const WalletScreen(),
        routes: [
          GoRoute(
            path: Routes.transfer.replaceAll('/', ''),
            name: Routes.transfer.replaceAll('/', ''),
            builder: (context, state) {
              final extra = state.extra as Map<String, dynamic>?;
              // return TransferScreen(availableBalance: extra?['balance'] ?? 0);
              return const TransferPointsScreen();
            },
          ),
        ],
      ),
    ],
  );
}

class Routes {
  static const String wallet = '/wallet';
  static const String transfer = '/transferPoints';
}
