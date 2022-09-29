import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphz/core/presentation/bloc/navigation_bloc.dart';

import '../bloc/weather_bloc.dart';

class AppBottomNavBar extends StatefulWidget {
  const AppBottomNavBar({Key? key}) : super(key: key);

  @override
  State<AppBottomNavBar> createState() => _AppBottomNavBarState();
}

class _AppBottomNavBarState extends State<AppBottomNavBar> {
  int _selectedIndex = 0;

  @override
  void initState() {
    BlocProvider.of<WeatherBloc>(context).add(GetLastWeekWeatherEvent());
    super.initState();
  }

  void _onItemTapped(int idx) {
    switch (idx) {
      case 0:
        BlocProvider.of<NavigationBloc>(context).add(OverviewEvent());
        break;
      case 1:
        BlocProvider.of<NavigationBloc>(context).add(TemperatureEvent());
        break;
      case 2:
        BlocProvider.of<NavigationBloc>(context).add(HumidityEvent());
        break;
      case 3:
        BlocProvider.of<NavigationBloc>(context).add(PressureEvent());
        break;
      case 4:
        BlocProvider.of<NavigationBloc>(context).add(LightEvent());
        break;
    }
    setState(() {
      _selectedIndex = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context)
          .copyWith(canvasColor: Theme.of(context).primaryColor),
      child: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_rounded),
            label: "Overview",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.thermostat),
            label: "Temperature",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.water_drop),
            label: "Humidity",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_drop_down_circle),
            label: "Pressure",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wb_sunny),
            label: "Light",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).iconTheme.color,
        unselectedItemColor: Colors.grey.shade200,
        onTap: _onItemTapped,
      ),
    );
  }
}
