import 'package:flutter/widgets.dart';

import '../../features/auth/presentation/pages/access_selection_page.dart';
import '../../features/auth/presentation/pages/pin_auth_page.dart';
import '../../features/qr_scan/presentation/pages/qr_list_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> get routes => {
    '/splash': (context) => const SplashPage(),
    '/accessSelection': (context) => const AccessSelectionPage(),
    '/pinAuth': (context) => const PinAuthPage(),
    '/qrList': (context) => const QrListPage(),
  };
}