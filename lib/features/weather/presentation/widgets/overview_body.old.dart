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
}
