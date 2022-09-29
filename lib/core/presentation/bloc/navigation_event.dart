part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();
  @override
  List<Object> get props => [];
}

class OverviewEvent extends NavigationEvent {}

class TemperatureEvent extends NavigationEvent {}

class HumidityEvent extends NavigationEvent {}

class PressureEvent extends NavigationEvent {}

class LightEvent extends NavigationEvent {}
