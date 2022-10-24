// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:auto_route/empty_router_widgets.dart' as _i1;
import 'package:flutter/material.dart' as _i5;

import '../../domain/entities/weather_list.dart' as _i6;
import '../pages/details_page.dart' as _i3;
import '../pages/overview_page.dart' as _i2;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    MainRouter.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.EmptyRouterPage());
    },
    OverviewRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.OverviewPage());
    },
    DetailsRoute.name: (routeData) {
      final args = routeData.argsAs<DetailsRouteArgs>();
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i3.DetailsPage(
              key: args.key, pageId: args.pageId, paramType: args.paramType));
    }
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(MainRouter.name, path: '/', children: [
          _i4.RouteConfig(OverviewRoute.name,
              path: '', parent: MainRouter.name),
          _i4.RouteConfig(DetailsRoute.name,
              path: ':pageId', parent: MainRouter.name)
        ])
      ];
}

/// generated route for
/// [_i1.EmptyRouterPage]
class MainRouter extends _i4.PageRouteInfo<void> {
  const MainRouter({List<_i4.PageRouteInfo>? children})
      : super(MainRouter.name, path: '/', initialChildren: children);

  static const String name = 'MainRouter';
}

/// generated route for
/// [_i2.OverviewPage]
class OverviewRoute extends _i4.PageRouteInfo<void> {
  const OverviewRoute() : super(OverviewRoute.name, path: '');

  static const String name = 'OverviewRoute';
}

/// generated route for
/// [_i3.DetailsPage]
class DetailsRoute extends _i4.PageRouteInfo<DetailsRouteArgs> {
  DetailsRoute(
      {_i5.Key? key, required int pageId, required _i6.ParamType paramType})
      : super(DetailsRoute.name,
            path: ':pageId',
            args: DetailsRouteArgs(
                key: key, pageId: pageId, paramType: paramType),
            rawPathParams: {'pageId': pageId});

  static const String name = 'DetailsRoute';
}

class DetailsRouteArgs {
  const DetailsRouteArgs(
      {this.key, required this.pageId, required this.paramType});

  final _i5.Key? key;

  final int pageId;

  final _i6.ParamType paramType;

  @override
  String toString() {
    return 'DetailsRouteArgs{key: $key, pageId: $pageId, paramType: $paramType}';
  }
}
