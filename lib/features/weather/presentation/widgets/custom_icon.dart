import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context).size;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final theme = Theme.of(context);
    double width = isLandscape ? device.width * 0.018 : device.width * 0.025;
    const double space = 10.0;

    Widget buildSingleBar(double h, double o) {
      return Container(
        width: width,
        height: isLandscape ? device.width * h : device.height * h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width / 2),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.iconTheme.color!.withOpacity(o),
              theme.highlightColor.withOpacity(o),
            ],
          ),
        ),
      );
    }

    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          buildSingleBar(0.07, 1),
          const SizedBox(
            width: space,
          ),
          buildSingleBar(0.055, 0.8),
          const SizedBox(
            width: space,
          ),
          buildSingleBar(0.085, 0.9),
          const SizedBox(
            width: space,
          ),
          buildSingleBar(0.115, 0.9),
          const SizedBox(
            width: space,
          ),
          buildSingleBar(0.07, 1),
          const SizedBox(
            width: space,
          ),
          buildSingleBar(0.06, 0.8),
        ],
      ),
    );
  }
}
