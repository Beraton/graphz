import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:graphz/features/weather/presentation/pages/details_page.dart';
import 'package:graphz/features/weather/presentation/pages/overview_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/',
      name: 'MainRouter',
      page: EmptyRouterPage,
      children: [
        AutoRoute(
          path: '',
          page: OverviewPage,
        ),
        AutoRoute(
          path: ':paramId',
          page: DetailsPage,
        ),
      ],
    )
  ],
)
class $AppRouter {}
