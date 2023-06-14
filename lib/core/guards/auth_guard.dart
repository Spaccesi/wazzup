import '../constants/app_routes.dart';

String? authGuard(authState) {
  if (authState != true) {
    return AppRoute.signIn.path;
  }
  return null;
}
