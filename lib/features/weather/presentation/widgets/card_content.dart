import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphz/features/weather/presentation/routes/router.gr.dart';
import 'package:graphz/features/weather/presentation/widgets/util/weather_sorting_utils.dart';

import '../../../../core/bloc/navigation_bloc.dart';
import '../../domain/entities/weather_list.dart';
import '../bloc/weather_bloc.dart';
import 'custom_icon.dart';

class CardContent extends StatelessWidget {
  final String? title;
  final ParamType paramType;
  const CardContent({super.key, this.title, required this.paramType});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final device = MediaQuery.of(context).size;

    return Container(
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            child: Container(
              width: device.width * 0.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(device.width * 0.02),
                  color: theme.primaryColor,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 5,
                      offset: Offset(5.0, 5.0),
                    ),
                  ]),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  BlocProvider.of<NavigationBloc>(context)
                      .add(NavigationPushPage(paramType));
                },
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          BlocBuilder<WeatherBloc, WeatherState>(
                            builder: (context, state) {
                              if (state is! WeatherLoaded) {
                                return Text(
                                  "-",
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.visible,
                                  style: theme.primaryTextTheme.bodyMedium,
                                );
                              }
                              if (state is WeatherLoaded) {
                                return Text(
                                  createCurrentValue(title!, state.weather),
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.visible,
                                  style: theme.primaryTextTheme.bodyMedium,
                                );
                              }
                              return Container();
                            },
                          ),
                          SizedBox(height: device.height * 0.04),
                          CustomIcon(),
                          SizedBox(height: device.height * 0.04),
                          Text(
                            title.toString(),
                            style: theme.primaryTextTheme.subtitle1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
