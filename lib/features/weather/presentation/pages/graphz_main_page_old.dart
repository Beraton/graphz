/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphz/core/presentation/bloc/bottom_nav_bar_bloc.dart';
import 'package:graphz/features/weather/presentation/bloc/weather_bloc.dart';
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
        BlocProvider<BottomNavBarBloc>(
          create: (BuildContext context) => sl<BottomNavBarBloc>(),
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
          child: buildBody(context),
        ),
        bottomNavigationBar: const AppBottomNavBar(),
      ),
    );
  }

  BlocBuilder buildBody(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is Initial) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    child: const Text(
                      "Initial state",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is WeatherLoading) {
          print("Weather loading()");
          return SizedBox(
            height: MediaQuery.of(context).size.height / 1.3,
            child: Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (state is WeatherLoaded) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: GraphzOverview(weather: state.weather),
            ),
          );
        } else if (state is Error) {
          return Container(
            height: MediaQuery.of(context).size.height / 3,
            child: Text(
              state.message,
              style: TextStyle(fontSize: 25),
            ),
          );
        }
        return Container();
      },
    );
  }
}
*/