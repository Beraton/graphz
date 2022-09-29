import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

//TODO: change this approach to super_enum to reduce boilerplate

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(ShowOverview()) {
    on<OverviewEvent>((event, emit) {
      emit(ShowOverview());
    });
    on<TemperatureEvent>((event, emit) {
      emit(ShowTemperature());
    });
    on<HumidityEvent>((event, emit) {
      emit(ShowHumidity());
    });
    on<PressureEvent>((event, emit) {
      emit(ShowPressure());
    });
    on<LightEvent>((event, emit) {
      emit(ShowLight());
    });
  }
}
