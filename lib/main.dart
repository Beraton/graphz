import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphz/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/bloc/navigation_bloc.dart';
import 'features/weather/presentation/pages/overview_page.dart';
import 'package:auto_route/auto_route.dart';
//import 'features/weather/presentation/routes/router.gr.dart' as app_router;
import 'features/weather/presentation/routes/router.gr.dart';
import 'injection_container.dart' as di;

void main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _appRouter = di.sl<AppRouter>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => di.sl<WeatherBloc>()),
        BlocProvider(create: (BuildContext context) => di.sl<NavigationBloc>())
      ],
      child: MaterialApp.router(
        title: 'Graphz',
        debugShowCheckedModeBanner: false,
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        theme: ThemeData.light().copyWith(
          primaryColor: Color.fromRGBO(50, 48, 57, 1), //darker grey
          iconTheme: IconThemeData(
            color: Colors.lightGreen[300],
          ),
          canvasColor: Color.fromRGBO(50, 48, 57, 1), //darker grey
          highlightColor: Colors.lightGreen,
          cardColor: Color.fromRGBO(217, 217, 217, 0.95),
          errorColor: Colors.redAccent,
          backgroundColor: Color.fromRGBO(50, 48, 57, 1), //darker grey
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.lightGreen[800],
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          primaryTextTheme: const TextTheme(
            titleLarge: TextStyle(
              fontFamily: 'Oxygen',
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            titleMedium: TextStyle(
              fontFamily: 'Oxygen',
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Color.fromRGBO(217, 217, 217, 0.95),
            ),
            titleSmall: TextStyle(
              fontFamily: 'Oxygen',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Color.fromRGBO(217, 217, 217, 0.85),
            ),
            bodyMedium: TextStyle(
              fontFamily: 'Oxygen',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Color.fromRGBO(217, 217, 217, 0.85),
            ),
            bodySmall: TextStyle(
              fontFamily: 'Oxygen',
              fontWeight: FontWeight.w400,
              fontSize: 13,
              color: Color.fromRGBO(217, 217, 217, 0.85),
            ),
          ),
        ),
      ),
    );
  }
}
