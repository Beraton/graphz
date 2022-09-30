import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphz/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:graphz/features/weather/presentation/widgets/util/weather_spot_generator.dart';
import 'package:graphz/features/weather/presentation/widgets/widgets.dart';

class GraphzOverview extends StatelessWidget {
  const GraphzOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
      if (state is WeatherLoading) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 3,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      if (state is WeatherLoaded) {
        return Column(
          children: const [
            GraphTitle(title: "Temperature [°C]"),
            SingleGraph(type: ParamType.temperature),
            SizedBox(height: 10),
            GraphTitle(title: "Humidity [%RH]"),
            SingleGraph(type: ParamType.humidity),
            SizedBox(height: 10),
            GraphTitle(title: "Pressure [hPa]"),
            SingleGraph(type: ParamType.pressure),
            SizedBox(height: 10),
            GraphTitle(title: "Light [lux]"),
            SingleGraph(type: ParamType.light),
            SizedBox(height: 10),
          ],
        );
      }
      if (state is Error) {
        return Container(
          child: const Text('Error occurred'),
        );
      }
      return Container();
    });
  }
}
