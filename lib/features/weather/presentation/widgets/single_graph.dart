import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphz/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:graphz/features/weather/presentation/widgets/util/weather_sorting_utils.dart';
import 'package:intl/intl.dart';

List<Color> gradientColors = [
  const Color(0xff23b6e6),
  const Color(0xff02d39a),
];

class SingleGraph extends StatelessWidget {
  final ParamType type;
  const SingleGraph({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is Initial) {
          return const SizedBox(
            child: Text('INITIAL STATE'),
          );
        }
        if (state is WeatherLoading) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is WeatherLoaded) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: LineChart(
              LineChartData(
                maxY: getMaxValue(state.weather, type),
                minY: getMinValue(state.weather, type),
                lineTouchData: LineTouchData(
                  enabled: true,
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                      return touchedBarSpots.map((LineBarSpot touchedSpot) {
                        const textStyle = TextStyle(
                          fontFamily: 'Raleway',
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        );
                        /* Individual value label */
                        return LineTooltipItem(
                            "${touchedSpot.y.toString()} \n @${DateFormat.E().add_jm().format(state.weather.weatherList[touchedSpot.spotIndex].time.toLocal())..toString()}",
                            textStyle);
                      }).toList();
                    },
                    tooltipBgColor: Colors.blueGrey.withOpacity(0.4),
                    fitInsideHorizontally: true,
                    fitInsideVertically: true,
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: generateChartSpots(state.weather, type),
                    isCurved: true,
                    barWidth: 2.5,
                    color: Theme.of(context).highlightColor,
                    dotData: FlDotData(
                      show: false,
                    ),
                    preventCurveOverShooting: true,
                  ),
                ],
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        const style = TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        );

                        /* DateTime parsed into local time */
                        String label = '';
                        label = DateFormat.Hm()
                            .format(state
                                .weather.weatherList[value.toInt()].time
                                .toLocal())
                            .toString();

                        // Ensure no label for the last record in the graph
                        if (value.toInt() ==
                                state.weather.weatherList.length - 1 ||
                            value.toInt() == 0) label = "";

                        return SideTitleWidget(
                          space: 4,
                          axisSide: meta.axisSide,
                          child: Text(label, style: style),
                        );
                      },
                      interval: 12,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  horizontalInterval: 1,
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      strokeWidth: 1,
                      color: Colors.black12.withOpacity(0.3),
                    );
                  },
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      strokeWidth: 1,
                      color: Colors.black12.withOpacity(0.1),
                    );
                  },
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
