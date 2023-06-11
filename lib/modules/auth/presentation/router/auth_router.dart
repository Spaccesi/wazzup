import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_routes.dart';
import '../pages/access_page.dart';

List<GoRoute> authRouter(bool authState) {
  final authRoute = [
    GoRoute(
      path: AppRoute.signIn.path,
      name: AppRoute.signIn.name,
      builder: (context, state) => const AccessPage(),
      // redirect: (context, state) => noAuthUserGuard(authState),
    ),
  ];
  return authRoute;
}
