import 'package:flutter/material.dart' show BuildContext;
import 'package:go_router/go_router.dart';

import '../../constants/app_routes.dart';

extension CurrentRoute on BuildContext {
  get currentRoute => GoRouter.of(this).location;

  goRoute(
    AppRoute page, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    String? id,
    Object? extra,
    bool replace = false,
  }) {
    if (replace) {
      return replaceNamed(
        page.name,
        pathParameters: id != null ? {'id': id} : pathParameters,
        queryParameters: queryParameters,
        extra: extra,
      );
    } else {
      return pushNamed(
        page.name,
        pathParameters: id != null ? {'id': id} : pathParameters,
        queryParameters: queryParameters,
        extra: extra,
      );
    }
  }
}
