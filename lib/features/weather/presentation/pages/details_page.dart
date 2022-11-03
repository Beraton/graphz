import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphz/features/weather/presentation/widgets/background.dart';
import 'package:graphz/features/weather/presentation/widgets/data_label.dart';
import 'package:graphz/features/weather/presentation/widgets/date_selector.dart';
import 'package:graphz/features/weather/presentation/widgets/single_graph.dart';

import '../../../../core/bloc/navigation_bloc.dart';
import '../../domain/entities/weather_list.dart';
import '../bloc/weather_bloc.dart';
import '../widgets/util/weather_sorting_utils.dart';

class DetailsPage extends StatelessWidget {
  final int pageId;
  final ParamType paramType;
  const DetailsPage({
    super.key,
    @PathParam() required this.pageId,
    required this.paramType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                    child: BlocBuilder<WeatherBloc, WeatherState>(
                      builder: (context, state) {
                        return SafeArea(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back),
                                color: Colors.white,
                                onPressed: () {
                                  BlocProvider.of<NavigationBloc>(context)
                                      .add(NavigationPreviousPage(context));
                                },
                              ),
                              Text(
                                mapParamTypeToTitle(paramType),
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .titleMedium,
                              ),
                              IconButton(
                                icon: const Icon(Icons.refresh),
                                color: Colors.white,
                                onPressed: () {
                                  BlocProvider.of<WeatherBloc>(context)
                                      .add(GetLastWeekWeatherEvent());
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  DataLabel(type: paramType),
                  DateSelector(),
                  SingleGraph(type: paramType),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
