import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphz/features/weather/presentation/widgets/util/weather_sorting_utils.dart';

import '../../domain/entities/weather_list.dart';
import '../bloc/weather_bloc.dart';

class DataLabel extends StatelessWidget {
  final ParamType type;
  const DataLabel({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.0),
            color: Theme.of(context).primaryColor,
            boxShadow: const [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 5,
                offset: Offset(5.0, 5.0),
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is Initial || state is WeatherLoading) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Current",
                      style: Theme.of(context).primaryTextTheme.titleMedium,
                    ),
                    Text(
                      "-",
                      style: Theme.of(context).primaryTextTheme.bodyMedium,
                    ),
                  ],
                );
              }
              if (state is WeatherLoaded) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Current",
                      style: Theme.of(context).primaryTextTheme.titleMedium,
                    ),
                    Text(
                      createCurrentValue(
                          mapParamTypeToTitle(type), state.weather),
                      style: Theme.of(context).primaryTextTheme.bodyMedium,
                    ),
                  ],
                );
              }
              if (state is Error) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Current",
                      style: Theme.of(context).primaryTextTheme.titleMedium,
                    ),
                    Text(
                      "Error",
                      style: Theme.of(context).primaryTextTheme.bodyMedium,
                    ),
                  ],
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
