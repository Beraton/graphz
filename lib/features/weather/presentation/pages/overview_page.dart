import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphz/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:graphz/features/weather/presentation/widgets/util/weather_sorting_utils.dart';
import 'package:graphz/features/weather/presentation/widgets/widgets.dart';

import '../../domain/entities/weather_list.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            CustomPaint(
              painter: Background(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 20,
                      top: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        BlocBuilder<WeatherBloc, WeatherState>(
                            builder: (context, state) {
                          return Row(
                            children: [
                              SafeArea(
                                child: IconButton(
                                  icon: const Icon(Icons.menu),
                                  color: Colors.white,
                                  onPressed: () {
                                    print("to implement logging");
                                    if (state is WeatherLoaded) {
                                      getSpecificDayWeather(
                                          DateTime.parse(
                                              '2022-10-28 13:22:22.000'),
                                          state.weather);
                                    }
                                  },
                                ),
                              ),
                              SafeArea(
                                child: IconButton(
                                  icon: const Icon(Icons.refresh),
                                  color: Colors.white,
                                  onPressed: () {
                                    BlocProvider.of<WeatherBloc>(context)
                                        .add(GetLastWeekWeatherEvent());
                                  },
                                ),
                              ),
                            ],
                          );
                        }),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            SafeArea(
                              child: Text('Overview',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .titleLarge),
                            ),
                            Row(
                              children: <Widget>[
                                Text('Good morning ',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .subtitle1),
                                Text('Jacob!',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .subtitle1),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.38,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      children: const [
                        CardContent(
                          title: "Temperature",
                          paramType: ParamType.temperature,
                        ),
                        CardContent(
                          title: "Humidity",
                          paramType: ParamType.humidity,
                        ),
                        CardContent(
                          title: "Pressure",
                          paramType: ParamType.pressure,
                        ),
                        CardContent(
                          title: "Light",
                          paramType: ParamType.light,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
