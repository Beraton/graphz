part of 'navigation_bloc.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object> get props => [];
}

class ShowOverview extends NavigationState {}

class ShowTemperature extends NavigationState {}

class ShowHumidity extends NavigationState {}

class ShowPressure extends NavigationState {}

class ShowLight extends NavigationState {}
