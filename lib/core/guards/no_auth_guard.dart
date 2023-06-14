import '../constants/app_routes.dart';

String? noAuthGuard(authState) {
  if (authState != true) {
    return AppRoute.signIn.path;
  }
  return null;
}
