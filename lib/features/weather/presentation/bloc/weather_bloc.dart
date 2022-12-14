import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:graphz/core/errors/failure.dart';
import 'package:graphz/features/weather/domain/usecases/get_full_year_weather.dart';
import 'package:graphz/features/weather/domain/usecases/get_selected_day_weather.dart';
import 'package:graphz/features/weather/domain/usecases/get_weekly_weather.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../domain/entities/weather_list.dart';

part 'weather_event.dart';
part 'weather_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server failure';
const String CACHE_FAILURE_MESSAGE = 'Cache failure';

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;
    default:
      return 'Unexpected failure';
  }
}

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetFullYearWeather fullYear;
  final GetWeeklyWeather weeklyWeather;
  final GetSelectedDayWeather selectedDayWeather;

  WeatherBloc({
    required this.fullYear,
    required this.weeklyWeather,
    required this.selectedDayWeather,
  }) : super(Initial()) {
    on<GetFullYearWeatherEvent>(_onGetFullYearWeatherEvent);
    on<GetLastWeekWeatherEvent>(_onGetLastWeekWeatherEvent);
    on<GetSelectedDayWeatherEvent>(_onGetSelectedDayWeatherEvent);
  }

  void _onGetFullYearWeatherEvent(
      GetFullYearWeatherEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    final failureOrWeather = await fullYear(NoParams());
    failureOrWeather.fold(
      (failure) => emit(Error(message: _mapFailureToMessage(failure))),
      (weather) => emit(WeatherLoaded(weather: weather)),
    );
  }

  void _onGetLastWeekWeatherEvent(
      GetLastWeekWeatherEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    final failureOrWeather = await weeklyWeather(NoParams());
    failureOrWeather.fold(
      (failure) => emit(Error(message: _mapFailureToMessage(failure))),
      (weather) => emit(WeatherLoaded(weather: weather)),
    );
  }

  void _onGetSelectedDayWeatherEvent(
      GetSelectedDayWeatherEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    final failureOrWeather =
        await selectedDayWeather(Params(selectedDay: event.selectedDay));
    failureOrWeather.fold(
      (failure) => emit(Error(message: _mapFailureToMessage(failure))),
      (weather) => emit(WeatherLoaded(weather: weather)),
    );
  }
}
