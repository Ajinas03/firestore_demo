import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

class RouteState {
  const RouteState._();

  /// [currentContext] return the top BuildContext
  static BuildContext get currentContext => rootNavigatorKey.currentContext!;
}
