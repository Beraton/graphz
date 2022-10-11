import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphz/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:graphz/features/weather/presentation/widgets/util/weather_sorting_utils.dart';
import 'package:graphz/features/weather/presentation/widgets/widgets.dart';
import 'package:graphz/features/weather/presentation/routes/router.gr.dart';

class OverviewBody extends StatelessWidget {
  const OverviewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoaded) {
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  print("card pressed");
                },
                child: Container(
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Temperature",
                            style: TextStyle(fontSize: 20),
                          ),
                          Icon(Icons.thermostat, size: 28),
                        ],
                      ),
                      Text(
                        "${state.weather.weatherList.last.temperature.toString()}°C",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  //padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  padding:
                      EdgeInsets.only(bottom: 10.0, left: 20.0, right: 20.0),
                  alignment: Alignment.topLeft,
                  //width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.red[600],
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).primaryColor,
                        offset: const Offset(
                          5.0,
                          5.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ), //BoxShadow
                      BoxShadow(
                        color: Colors.white,
                        offset: const Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ), //BoxShadow
                    ],
                  ),
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
