import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphz/core/presentation/bloc/navigation_bloc.dart';
import 'package:graphz/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:graphz/features/weather/presentation/widgets/util/weather_spot_generator.dart';
import 'package:graphz/features/weather/presentation/widgets/widgets.dart';

import '../../../../injection_container.dart';

class GraphzMainPage extends StatelessWidget {
  const GraphzMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherBloc>(
          create: (BuildContext context) => sl<WeatherBloc>(),
        ),
        BlocProvider<NavigationBloc>(
          create: (BuildContext context) => sl<NavigationBloc>(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Graphz"),
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    child: const Icon(Icons.refresh),
                    onTap: () {
                      BlocProvider.of<WeatherBloc>(context)
                          .add(GetLastWeekWeatherEvent());
                    },
                  ),
                );
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: buildBody(context),
            ),
          ),
        ),
        bottomNavigationBar: const AppBottomNavBar(),
      ),
    );
  }

  BlocBuilder buildBody(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        if (state is ShowOverview) {
          return GraphzOverview();
        } else if (state is ShowTemperature) {
          return Column(
            children: const [
              GraphTitle(title: "Temperature [°C]"),
              SingleGraph(type: ParamType.temperature),
            ],
          );
        } else if (state is ShowHumidity) {
          return Column(
            children: const [
              GraphTitle(title: "Humidity [%RH]"),
              SingleGraph(type: ParamType.humidity),
            ],
          );
        } else if (state is ShowPressure) {
          return Column(
            children: const [
              GraphTitle(title: "Pressure [hPa]"),
              SingleGraph(type: ParamType.pressure),
            ],
          );
        } else if (state is ShowLight) {
          return Column(
            children: const [
              GraphTitle(title: "Light [lux]"),
              SingleGraph(type: ParamType.light),
            ],
          );
        }
        return Container();
      },
    );
  }
}
