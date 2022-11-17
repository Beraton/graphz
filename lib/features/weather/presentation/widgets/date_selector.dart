import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/weather_bloc.dart';

class DateSelector extends StatefulWidget {
  const DateSelector({super.key});

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  DateTime today = DateTime.now();
  DateTime currentDate = DateTime.now();
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dateController.text =
        DateFormat("yyyy-MM-dd").format(currentDate).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    currentDate = currentDate.subtract(Duration(days: 1));
                    dateController.text =
                        DateFormat("yyyy-MM-dd").format(currentDate).toString();
                  });
                  BlocProvider.of<WeatherBloc>(context)
                      .add(GetSelectedDayWeatherEvent(currentDate));
                },
                icon: Icon(Icons.arrow_back),
              ),
              Text(
                dateController.text,
                style: Theme.of(context).primaryTextTheme.bodyMedium,
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    if (currentDate.isBefore(today)) {
                      currentDate = currentDate.add(Duration(days: 1));
                    }
                    dateController.text =
                        DateFormat("yyyy-MM-dd").format(currentDate).toString();
                    BlocProvider.of<WeatherBloc>(context)
                        .add(GetSelectedDayWeatherEvent(currentDate));
                  });
                },
                icon: Icon(Icons.arrow_forward),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(const Duration(days: 365)),
                  lastDate: DateTime.now());
              if (pickedDate != null) {
                String newPickedDate =
                    DateFormat("yyyy-MM-dd").format(pickedDate);

                setState(() {
                  currentDate = DateTime.parse(newPickedDate);
                  dateController.text = newPickedDate;
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
