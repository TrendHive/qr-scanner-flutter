import 'package:core/constants.dart';
import 'package:core/navigation/navigation_service.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/home/home_page.dart';
import 'package:presentation/router/route_path.dart';

class QRScannerRouter {
  late GoRouter router;

  GoRouter getRouter() => GoRouter(
    navigatorKey: NavigationService.navigatorKey,
    routes: getRoutes(),
  );

  static RoutePath path = RoutePath(pathEnd: CoreConstants.empty);

  List<RouteBase> getRoutes() {
    return [
      GoRoute(path: path.pathEnd(), builder: (context, state) => HomePage()),
    ];
  }
}
