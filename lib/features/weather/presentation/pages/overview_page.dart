import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphz/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:graphz/features/weather/presentation/pages/details_page.dart';
import 'package:graphz/features/weather/presentation/routes/router.gr.dart';
import 'package:graphz/features/weather/presentation/widgets/card_content.dart';
import 'package:graphz/features/weather/presentation/widgets/util/weather_sorting_utils.dart';
import 'package:graphz/features/weather/presentation/widgets/widgets.dart';

import '../../../../injection_container.dart';
import '../widgets/background.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WeatherBloc>(
      create: (BuildContext context) => sl<WeatherBloc>(),
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Stack(
            children: <Widget>[
              CustomPaint(
                painter: Background(),
                child:
                    Container(height: MediaQuery.of(context).size.height * 0.5),
              ),
              Column(
                children: <Widget>[
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
                          return SafeArea(
                            child: IconButton(
                              icon: const Icon(Icons.menu),
                              color: Colors.white,
                              onPressed: () {
                                BlocProvider.of<WeatherBloc>(context)
                                    .add(GetLastWeekWeatherEvent());
                              },
                            ),
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
                      children: [
                        CardContent(
                            title: "Temperature",
                            paramType: ParamType.temperature),
                        CardContent(
                            title: "Humidity", paramType: ParamType.humidity),
                        CardContent(
                            title: "Pressure", paramType: ParamType.pressure),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          /*
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: buildBody(context),
            ),
          ),
          */
        ),
      ),
    );
  }

  BlocBuilder buildBody(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
      if (state is WeatherLoading) {
        return const CircularProgressIndicator();
      } else if (state is WeatherLoaded) {
        return const OverviewBody();
      } else if (state is Error) {
        return const SizedBox(
          child: Text("Error occurred"),
        );
      }
      return Container();
    });
  }
}
