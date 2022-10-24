import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphz/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:graphz/features/weather/presentation/widgets/util/weather_sorting_utils.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/weather_list.dart';

List<Color> gradientColors = [
  const Color(0xff23b6e6),
  const Color(0xff02d39a),
];

class SingleGraph extends StatelessWidget {
  final ParamType type;
  const SingleGraph({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildGraph(BuildContext context, WeatherLoaded state) {
      return LineChart(
        LineChartData(
          maxY: getMaxValue(state.weather, type),
          minY: getMinValue(state.weather, type),
          lineTouchData: LineTouchData(
            enabled: true,
            touchTooltipData: LineTouchTooltipData(
              getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                return touchedBarSpots.map((LineBarSpot touchedSpot) {
                  const textStyle = TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  );
                  /* Individual value label */
                  return LineTooltipItem(
                      "${touchedSpot.y.toString()} \n @${DateFormat.E().add_jm().format(state.weather.weatherList[touchedSpot.spotIndex].time.toLocal())..toString()}",
                      textStyle);
                }).toList();
              },
              tooltipBgColor: Theme.of(context).primaryColor.withOpacity(0.8),
              fitInsideHorizontally: true,
              fitInsideVertically: true,
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: generateChartSpots(state.weather, type),
              isCurved: true,
              preventCurveOverShooting: true,
              barWidth: 2.5,
              isStrokeCapRound: true,
              color: Theme.of(context).highlightColor,
              dotData: FlDotData(
                show: false,
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).highlightColor.withOpacity(0.3),
                    Theme.of(context).highlightColor.withOpacity(0.15),
                  ],
                ),
              ),
            ),
          ],
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.white10, width: 1),
          ),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  TextStyle? style =
                      Theme.of(context).primaryTextTheme.bodySmall;
                  /* DateTime parsed into local time */
                  String label = '';
                  label = DateFormat.Hm()
                      .format(state.weather.weatherList[value.toInt()].time
                          .toLocal())
                      .toString();
                  // Ensure no label for the last record in the graph
                  if (value.toInt() == state.weather.weatherList.length - 1 ||
                      value.toInt() == 0) label = "";
                  return SideTitleWidget(
                    space: 4,
                    axisSide: meta.axisSide,
                    child: Text(label, style: style),
                  );
                },
                interval: 40,
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
                color: Colors.white10,
              );
            },
            getDrawingHorizontalLine: (value) {
              return FlLine(
                strokeWidth: 1,
                color: Colors.white10,
              );
            },
          ),
        ),
      );
    }

    Widget _buildPlaceholderGraph() {
      return LineChart(
        LineChartData(
          maxY: 8.0,
          minY: 2.0,
          lineBarsData: [
            LineChartBarData(
              spots: const [
                FlSpot(1.0, 6.0),
                FlSpot(2.0, 4.5),
                FlSpot(3.0, 6.5),
                FlSpot(4.0, 5.0),
                FlSpot(5.0, 5.5),
                FlSpot(6.0, 7.0),
                FlSpot(7.0, 5.5),
                FlSpot(8.0, 4.0),
                FlSpot(9.0, 5.5),
                FlSpot(10.0, 4.5),
              ],
              isCurved: true,
              preventCurveOverShooting: true,
              barWidth: 2.5,
              isStrokeCapRound: true,
              color: Theme.of(context).highlightColor,
              dotData: FlDotData(
                show: false,
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).highlightColor.withOpacity(0.3),
                    Theme.of(context).highlightColor.withOpacity(0.15),
                  ],
                ),
              ),
            ),
          ],
          lineTouchData: LineTouchData(
            enabled: false,
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.white10, width: 1),
          ),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
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
                color: Colors.white10,
              );
            },
            getDrawingHorizontalLine: (value) {
              return FlLine(
                strokeWidth: 1,
                color: Colors.white10,
              );
            },
          ),
        ),
      );
    }

    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is Initial) {
          return const SizedBox(
            child: Text('INITIAL STATE'),
          );
        }
        if (state is WeatherLoading) {
          return AspectRatio(
            aspectRatio: 3 / 2,
            child: Container(
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Stack(
                  children: [
                    Center(child: CircularProgressIndicator()),
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: <Color>[
                            Colors.white12,
                            Colors.white10,
                          ],
                        ),
                      ),
                    ),
                    _buildPlaceholderGraph(),
                  ],
                ),
              ),
            ),
            /*
            child: const Center(
              child: CircularProgressIndicator(),
            ),
            */
          );
        }
        if (state is WeatherLoaded) {
          return AspectRatio(
            aspectRatio: 3 / 2,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: _buildGraph(context, state),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
